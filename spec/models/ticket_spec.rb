require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket) { create(:ticket) }
  it "saves without error" do
    expect { ticket.save! }.not_to raise_error
  end

  describe "#claim!" do
    it "claims the ticket" do
      expect{ticket.claim!("Tommy")}.to change(TicketCleanupWorker.jobs, :size).by(1)
      expect(ticket.name).to eq("Tommy")
      expect(ticket.claimed?).to eq(true)
    end
  end

  describe "#set_guid" do
    it "sets a guid before create" do
      expect(ticket.guid).not_to be_nil
    end
  end

  describe "cleanup!" do
    let(:ticket) { create(:ticket, :claimed) }

    it "unclaims the ticket" do
      ticket.cleanup!
      expect(ticket.name).to be_nil
      expect(ticket.status).to eq("available")
    end
  end
end
