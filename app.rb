ENV["RACK_ENV"] ||= "development"

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

Dotenv.load

require 'time'
require 'uri'
require 'active_support/all'

Dir[File.join(File.dirname(__FILE__), 'config', 'initializers', '*.rb')].each do |file|
  require file
end

Dir[File.join(File.dirname(__FILE__), 'lib', '**', '*.rb')].each do |file|
  require file
end

# Ensure App::Base is always required first
require File.join(File.dirname(__FILE__), 'app', 'api', 'base.rb')

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  unless file == "./app/api/base.rb"
    require file
  end
end



# Dir["./lib/**/*.rb"].each { |f| require f }
# # Ensure App::Base is always required first
# require "./app/base.rb"
# Dir["./app/**/*.rb"].each { |f| require f unless f == "./app/api/base.rb" }
