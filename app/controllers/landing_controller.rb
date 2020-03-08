class LandingController < ApplicationController
  def index
    @event = Event.first
    @sold_out = @event.available_tickets_count == 0
  end
end
