ENV['RACK_ENV'] = "test"

require File.expand_path(File.dirname(__FILE__) + "/../app.rb")

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
