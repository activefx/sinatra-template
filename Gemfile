# define our source to loook for gems
source "http://rubygems.org/"

ruby '2.1.2'

gem "rake"
gem "sinatra"
gem "thin"
gem "json"

group :development do
  gem "foreman"
end

group :test do
  gem "guard-rspec"
  gem "rack-test"
end

gem "pry", group: [ :development, :test ]
