require 'rails_helper'

RSpec.describe "Landings", type: :request do

  describe "GET /" do
    before do
      create(:event)
    end

    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

end
