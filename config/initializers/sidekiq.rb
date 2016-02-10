# /config/initializers/sidekiq.rb
# https://gist.github.com/stevenharman/8590937
#
current_web_concurrency = Proc.new do
  web_concurrency = ENV['WEB_CONCURRENCY']
  web_concurrency ||= Puma.respond_to?(:cli_config) && Puma.cli_config.options.fetch(:max_threads)
  web_concurrency || 16
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: 'sinatra' }

  ActiveRecord::Base.connection_pool.disconnect!

  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[ENV["RACK_ENV"]]
    config['reaping_frequency'] = ENV['DATABASE_REAP_FREQ'] || 10 # seconds
    config['pool'] = ENV['WORKER_DB_POOL_SIZE'] || Sidekiq.options[:concurrency]
    ActiveRecord::Base.establish_connection(config)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: 'sinatra', :size => 1 }

  ActiveRecord::Base.connection_pool.disconnect!

  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[ENV["RACK_ENV"]]
    config['reaping_frequency'] = ENV['DATABASE_REAP_FREQ'] || 10 # seconds
    config['pool'] = ENV['WEB_DB_POOL_SIZE'] || current_web_concurrency.call
    ActiveRecord::Base.establish_connection(config)
  end
end
