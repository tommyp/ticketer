require 'rails_helper'

RSpec.describe TicketCleanupWorker do
  describe "#perform" do
    context "for a sold ticket" do
      let(:ticket) { create(:ticket, :sold) }

      it "does nothing" do
        expect{described_class.new.perform(ticket.id)}.to_not change{ticket.status}
      end
    end

    context "for a claimed ticket" do
      let(:ticket) { create(:ticket, :claimed) }

      it "resets it back to being available" do
        old_guid = ticket.guid
        expect{described_class.new.perform(ticket.id)}.to change{ticket.reload.status}.to("available")
        expect(ticket.name).to be_nil
        expect(ticket.stripe_checkout_session_id).to be_nil
        expect(ticket.guid).to_not eq(old_guid)
      end
    end
  end
end
