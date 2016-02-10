# define our source to loook for gems
source "http://rubygems.org/"

ruby '2.3.0'

gem "sqlite3"
gem "sinatra", require: "sinatra/base"
gem "sinatra-activerecord"
gem "sinatra-contrib"
gem "puma"
gem "json"
gem "oj"
gem "dotenv"
gem "redis-namespace"
gem "sidekiq"

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

gem "pry", group: [ :development, :test ]
gem "pry-remote", group: [ :development, :test ]
