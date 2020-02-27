require 'rails_helper'

RSpec.describe ChargeController, type: :controller do

  describe "GET /success" do
    let(:ticket) { create(:ticket) }

    let(:checkout_session_id) { "some-stripe-id" }

    before do
      request.cookies['ticket_guid'] = ticket.guid
    end

    it "returns http success" do
      get :success, params: { session_id: checkout_session_id }

      ticket.reload
      expect(ticket.stripe_checkout_session_id).to eq(checkout_session_id)
    end
  end

end
