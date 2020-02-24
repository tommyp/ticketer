class GuestsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def reset
    Ticket.destroy_all
    event = Event.first

    5.times do
      Ticket.create!(
        event_id: event.id,
        status: :available,
      )
    end

    redirect_to root_path
  end
end
