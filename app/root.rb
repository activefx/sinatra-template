module App
  class Root < App::Base

    # GET /
    #
    # Set ROOT_REDIRECT to redirect to main site
    #
    get '/' do
      if to_url = ENV['ROOT_REDIRECT']
        redirect to_url
      else
        'Hi!'
      end
    end

  end
end
