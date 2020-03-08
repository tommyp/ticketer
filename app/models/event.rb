class Event < ApplicationRecord
  has_many :tickets

  def update_counts!(ticket)
    case ticket.status
    when "claimed" # moving from avilable to claimed
      self.available_tickets_count -= 1
      self.claimed_tickets_count += 1
    when "sold" # moving from claimed to sold
      self.claimed_tickets_count -= 1
      self.sold_tickets_count += 1
    when "available" # moving from claimed to available
      self.claimed_tickets_count -= 1
      self.available_tickets_count += 1
    end

    self.save!
  end
end
