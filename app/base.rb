module App
  class Base < Sinatra::Base


    configure do

      # Set the environment from RACK_ENV
      set :environment, (ENV['RACK_ENV'] || :development)

      # Set the root as the overall application directory
      set :root, File.expand_path("..", File.dirname(__FILE__))

      # Log to stdout and to a file
      enable :logging
      file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file

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

  end
end
