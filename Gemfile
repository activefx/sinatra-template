# define our source to loook for gems
source "http://rubygems.org/"

ruby '2.1.3'

gem "sinatra", require: "sinatra/base"
gem "unicorn"
gem "json"
gem "activesupport", "~> 4", "< 5"

group :development do
  gem "foreman"
  gem "rake"
  gem "sinatra-reloader"
end

group :test do
  gem "guard-rspec"
  gem "rack-test"
end

gem "pry", group: [ :development, :test ]

