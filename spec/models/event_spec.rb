require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }
  it "saves without error" do
    expect {event.save!}.not_to raise_error
  end
end
