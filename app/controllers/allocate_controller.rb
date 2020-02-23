class AllocateController < ApplicationController
  def index
    ticket = Ticket.where(event_id: params[:event_id], status: :available).first

    if ticket
      ticket.claim!(params[:name])
      cookies[:ticket_guid] = ticket.guid

      respond_to do |format|
        format.html { redirect_to charge_path }
      end
    end
  end
end
