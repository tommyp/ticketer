class Ticket < ApplicationRecord
  belongs_to :event
  enum status: [:available, :claimed, :sold]

  def claim(customer_name)
    name = customer_name
    status = :claimed
    save!
  end
end
