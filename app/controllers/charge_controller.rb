class ChargeController < ApplicationController
  def index
    ticket = Ticket.where(event_id: params[:event_id], status: :available).first

    if ticket
      ticket.claim(params[:name])

      respond_to do |format|
        format.html {
          redirect_to checkout_path, params: {
            ticket: {
              id: ticket.id
            }
          }
        }
      end
    else
      flash[:alert] = "I'm sorry, but all tickets have been allocated."
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    end
  end
end
