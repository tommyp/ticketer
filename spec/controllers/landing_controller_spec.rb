require 'rails_helper'

RSpec.describe LandingController, type: :controller do

  describe "GET /" do
    before do
      create(:event)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
