require File.join(File.dirname(__FILE__), 'app.rb')

routes = {
  "/"           => App::Root,
  "/echo"       => App::Echo,
}

if defined?(Sidekiq) && ENV['REDIS_URL']
  require 'sidekiq/web'
  routes.merge!({
    "/sidekiq"    => Sidekiq::Web
  })
end

run Rack::URLMap.new(routes)
