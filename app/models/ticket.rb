class Ticket < ApplicationRecord
  belongs_to :event

  enum status: {
    available: 0,
    claimed: 1,
    sold: 2,
  }

  validates_uniqueness_of :name, allow_nil: true

  before_create :set_guid

  def claim!(customer_name)
    self.name = customer_name
    self.status = :claimed
    save!
    TicketCleanupWorker.perform_in(5.minutes, self.id)
  end

  def sell!
    self.status = "sold"
    save!
  end

  def cleanup!
    self.status = "available"
    self.name = nil
    save!
  end

  def set_guid
    self.guid = SecureRandom.uuid
  end
end
