class GuestsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def reset
    Ticket.destroy_all
    event = Event.first
    event.update_attributes!({
      available_tickets_count: 5,
      claimed_tickets_count: 0,
      sold_tickets_count: 0,
    })

    5.times do
      Ticket.create!(
        event_id: event.id,
        status: :available,
      )
    end

    redirect_to root_path
  end
end
