require 'rails_helper'

RSpec.describe "Allocate", type: :request do

  describe "POST /allocate" do
    let(:ticket) { create(:ticket) }

    it "returns http success" do
      post "/allocate", params: { name: "John Smith", event_id: ticket.event_id}

      ticket.reload
      expect(ticket.claimed?).to eq(true)
      expect(ticket.name).to eq("John Smith")
      expect(response.cookies['ticket_guid']).to eq(ticket.guid)
      expect(response).to redirect_to(charge_path)
    end
  end

end
