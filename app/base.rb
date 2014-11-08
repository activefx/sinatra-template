module App
  class Base < Sinatra::Base


    configure do
      # Set the root as the overall application directory
      set :root, File.expand_path("..", File.dirname(__FILE__))

      # Log to stdout and to a file
      enable :logging
      file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file
    end

  end
end
