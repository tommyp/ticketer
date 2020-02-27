class ChargeController < ApplicationController
  before_action :find_ticket

  def index
    @stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'Ticket',
        description: 'Ticket for the best show ever',
        amount: 500,
        currency: 'gbp',
        quantity: 1,
      }],
      success_url: ENV.fetch('STRIPE_SUCCESS_URL', 'https://ticketer.test/success?session_id={CHECKOUT_SESSION_ID}'),
      cancel_url: ENV.fetch('STRIPE_CANCEL_URL', 'https://ticketer.test/cancel'),
    )
  end

  def success
    @ticket.stripe_checkout_session_id = params[:session_id]
    @ticket.save!
  end

  private

  def find_ticket
    @ticket = Ticket.find_by_guid(cookies[:ticket_guid])
  end
end
