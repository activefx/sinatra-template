require 'spec_helper'

RSpec.describe App::Echo do

  def app
    @app ||= described_class
  end

  context "GET '/echo'" do

    it "is successful" do
      get '/'
      expect(last_response).to be_ok
    end

    it "returns a JSON response" do
      get '/'
      expect(JSON.parse(last_response.body)['status']).to eq 'ok'
    end

    it "optionally calculates the response time" do
      get '/', requested_at: URI.encode(Time.now.to_s)
      expect(JSON.parse(last_response.body)['response_time']).not_to be_nil
    end

  end

  context "GET '/echo/error'" do

    it "is unsuccessful" do
      get '/error'
      expect(last_response.status).to eq 500
    end

  end

end

