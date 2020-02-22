class LandingController < ApplicationController
  def index
    @event = Event.first
  end
end
