require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }
  it "saves without error" do
    expect {event.save!}.not_to raise_error
  end

  describe "#update_counts!" do
    context "with a newly claimed ticket" do
      let(:ticket) { create(:ticket, status: "claimed" )}

      it "updates the claimed and available counts" do
        event.update_counts!(ticket)
        expect(event.available_tickets_count).to eq(4)
        expect(event.claimed_tickets_count).to eq(1)
      end
    end

    context "with a newly sold ticket" do
      let(:event) { create(:event, claimed_tickets_count: 5) }
      let(:ticket) { create(:ticket, status: "sold" )}

      it "updates the claimed and available counts" do
        event.update_counts!(ticket)
        expect(event.claimed_tickets_count).to eq(4)
        expect(event.sold_tickets_count).to eq(1)
      end
    end

    context "with a newly available ticket" do
      let(:event) {
        create(:event,
          available_tickets_count: 0,
          claimed_tickets_count: 5
        )
      }

      let(:ticket) { create(:ticket, status: "available" )}

      it "updates the claimed and available counts" do
        event.update_counts!(ticket)
        expect(event.claimed_tickets_count).to eq(4)
        expect(event.available_tickets_count).to eq(1)
      end
    end
  end
end
