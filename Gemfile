# define our source to loook for gems
source "http://rubygems.org/"

ruby '2.3.0'

gem "sinatra", require: "sinatra/base"
gem "unicorn"
gem "json"
gem "activesupport", "~> 4", "< 5"
gem "oj"

group :development do
  gem "foreman"
  gem "rake"
  gem "sinatra-reloader"
end

group :test do
  gem "rspec", "~> 3.1"
  gem "guard-rspec"
  gem "rack-test"
  gem "fakeredis"
end

gem "dotenv", group: [ :development, :test ]
gem "pry", group: [ :development, :test ]
gem "pry-remote", group: [ :development, :test ]

