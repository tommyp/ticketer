class AllocateController < ApplicationController
  def index
    ticket = Ticket.where(event_id: params[:event_id], status: :available).first

    if ticket
      begin
        ticket.claim!(params[:name])
        cookies[:ticket_guid] = ticket.guid

        redirect_to charge_path
      rescue ActiveRecord::RecordInvalid => e
        flash[:alert] = "It looks like you already have a ticket #{params[:name]} and tickets are only 1 per person!"

        redirect_to root_path
      end
    else
      flash[:alert] = "It looks like there are no more tickets."

      redirect_to root_path
    end
  end
end
