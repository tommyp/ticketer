class AllocateController < ApplicationController
  def index
    ticket = Ticket.where(event_id: params[:event_id], status: :available).first

    if ticket
      begin
        ticket.claim!(params[:name])
        cookies[:ticket_guid] = ticket.guid

        respond_to do |format|
          format.html { redirect_to charge_path }
        end
      rescue ActiveRecord::RecordInvalid => e
        flash[:alert] = "It looks like you already have a ticket #{params[:name]} and tickets are only 1 per person!"

        respond_to do |format|
          format.html { redirect_to root_path }
        end
      end
    end
  end
end
