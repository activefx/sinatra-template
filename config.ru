# require File.expand_path("../config/boot.rb", __FILE__)

require File.join(File.dirname(__FILE__), 'app.rb')

run Rack::URLMap.new({
  "/"           => App::Root,
  "/echo"       => App::Echo
})
