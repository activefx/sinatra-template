module App
  class Echo < Sinatra::Base

    get '/' do
      response = { status: 'ok' }

      begin
        requested_at = Time.parse(URI.decode(params[:requested_at]))
        response_time = (Time.now - requested_at).round(5)
        response.merge!(response_time: response_time)
      rescue; end

      response.to_json
    end

  end
end
