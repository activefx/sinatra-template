require 'spec_helper'

RSpec.describe App::Root do

  def app
    @app ||= described_class
  end

  context "GET '/'" do

    it "is successful" do
      get '/'
      expect(last_response).to be_ok
    end
  end

end
