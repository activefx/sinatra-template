# Sinatra Template

Simple Sinatra template for building Ruby microservices. Bundler, Foreman, Thin, JSON, RSpec, and Guard.

# Setup 

````
git clone git://github.com/activefx/sinatra-template.git <new_application_name>
bundle
bundle exec foreman start 
````

# Heroku Deployment

````
heroku apps:create <new_application_name>
git push heroku master
````

# Configuring Rollbar 

Add ROLLBAR_SERVER_SIDE_ACCESS_TOKEN env variable to the .env file and the Rollbar gem to the Gemfile
````
gem "rollbar"
````

Inside the lib directory, create request_data_extractor.rb
````
class RequestDataExtractor
  include Rollbar::RequestDataExtractor
  def from_rack(env)
    extract_request_data_from_rack(env).merge({
      :route => env["PATH_INFO"]
    })
  end
end
````

Within app/base.rb, add the following:
````
configure do
  Rollbar.configure do |config|
    config.access_token = ENV['ROLLBAR_SERVER_SIDE_ACCESS_TOKEN']
    config.environment = Sinatra::Base.environment
    config.framework = "Sinatra: #{Sinatra::VERSION}"
    config.root = settings.root
  end
end
````

Add an error block to app/base.rb or only the route files that will use Rollbar for error handling
````
error do
  # To send the exception traceback:
  request_data = RequestDataExtractor.new.from_rack(env)
  Rollbar.report_exception(env['sinatra.error'], request_data)

  "We're sorry, but something went wrong."
end
````

# License 

Copyright (c) 2014 Matthew Solt

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
