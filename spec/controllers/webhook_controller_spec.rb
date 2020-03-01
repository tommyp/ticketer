require 'rails_helper'

RSpec.describe WebhookController, type: :request do

  describe "POST /" do
    let(:stripe_checkout_id) { "some-stripe-checkout-id" }

    let!(:ticket) {
      create(:ticket,
        status: "claimed",
        stripe_checkout_session_id: stripe_checkout_id
      )
    }

    let(:event) {
      {
        "type" => 'checkout.session.completed',
        "data" => {
          "object" => {
            "client_reference_id" => stripe_checkout_id
          }
        }
      }
    }

    let(:headers) {
      {
        "Stripe-Signature" => stripe_event_signature(event.to_json)
      }
    }

    before do
      expect(Stripe::Webhook).to receive(:construct_event).with(event.to_json, headers["Stripe-Signature"], anything).and_return(event)
    end

    it "returns http success" do
      post '/webhook', params: event, headers: headers, as: :json
      expect(response).to have_http_status(:success)
      expect(ticket.reload.status).to eq("sold")
    end
  end

end
