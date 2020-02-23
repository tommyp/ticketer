class ChargeController < ApplicationController
  def index
    @ticket = Ticket.find_by_guid(cookies[:ticket_guid])
  end
end
