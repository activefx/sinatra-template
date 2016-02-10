module App
  class Base < Sinatra::Base

    def self.redis_enabled?
      ENV['REDIS_URL']
    end

    def redis_enabled?
      self.class.redis_enabled?
    end

    def self.error_reporting_enabled?
      defined?(Rollbar) && ENV['ROLLBAR_SERVER_SIDE_ACCESS_TOKEN'].present?
    end

    def error_reporting_enabled?
      self.class.error_reporting_enabled?
    end


    configure do

      # Set the environment from RACK_ENV
      set :environment, (ENV['RACK_ENV'] || :development)

      # Set the root as the overall application directory
      set :root, File.expand_path("..", File.dirname(__FILE__))

      # Enable logging
      enable :logging

      # Disable cookie based sessions
      set :sessions, false

      # Disable the POST _method hack
      set :method_override, false

      # Disable static file routes
      set :static, false

      # Disable the built-in web server, use foreman instead
      set :run, false

      # Log exception backtraces to STDERR
      set :dump_errors, true

    end

    configure :development do

      # Enable error pages in development
      set :show_exceptions, true

    end

    configure :test do

      if redis_enabled?
        # Use Fakeredis in the test environment
        set :redis, Redis.new
      end

    end

    configure :development, :test do

      set :host, 'localhost:5000'

      # Disable SSL in development
      set :force_ssl, false

      # Log to stdout and to a file
      file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file

    end

    configure :development, :production do

      if error_reporting_enabled?
        Rollbar.configure do |config|
          config.disable_monkey_patch = true
          config.access_token = ENV['ROLLBAR_SERVER_SIDE_ACCESS_TOKEN']
          config.environment = settings.environment
          config.framework = "Sinatra: #{Sinatra::VERSION}"
          config.root = settings.root
        end
      end

      if redis_enabled?
        set :redis, Redis.new(url: ENV['REDIS_URL'])
      end

    end

    error do
      if error_reporting_enabled?
        request_data = RequestDataExtractor.new.from_rack(env)
        Rollbar.error(env['sinatra.error'], request_data)
      end

      status 500
      "We're sorry, but something went wrong."
    end

    def redis
      settings.redis if redis_enabled?
    end

    # https://github.com/mperham/sidekiq/wiki/FAQ#how-do-i-push-a-job-to-sidekiq-without-ruby
    #
    def queue_notification(notification)
      if redis_enabled?
        redis.lpush("sidekiq:queue:default", notification.to_message)
      end
    end

  end
end
