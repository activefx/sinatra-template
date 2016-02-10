if defined?(Rollbar)
  require 'rollbar/request_data_extractor'

  class RequestDataExtractor
    include Rollbar::RequestDataExtractor

    def from_rack(env)
      extract_request_data_from_rack(env).merge \
        route: env["REQUEST_PATH"]
    end

  end
end
