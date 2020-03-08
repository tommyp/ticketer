require 'rails_helper'

RSpec.describe AllocateController, type: :controller do

  describe "POST /allocate" do
    context "when there is a ticket" do
      let(:ticket) { create(:ticket) }

      it "allocates the ticket" do
        post :index, params: { name: "John Smith", event_id: ticket.event_id}

        ticket.reload
        expect(ticket.claimed?).to eq(true)
        expect(ticket.name).to eq("John Smith")
        expect(response.cookies['ticket_guid']).to eq(ticket.guid)
        expect(response).to redirect_to(charge_path)
      end
    end

    context "when the customer already has a ticket" do
      let(:ticket) { create(:ticket, :claimed) }

      before do
        create(:ticket, event: ticket.event)
      end

      it "redirects to root" do
        post :index, params: { name: ticket.name, event_id: ticket.event_id}

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("It looks like you already have a ticket John Smith and tickets are only 1 per person!")
      end
    end

    context "when there are no more available tickets" do
      let(:ticket) { create(:ticket, :sold) }

      it "redirects to root" do
        post :index, params: { name: ticket.name, event_id: ticket.event_id}

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("It looks like there are no more tickets.")
      end
    end
  end

end
