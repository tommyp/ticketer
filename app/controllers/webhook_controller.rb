class WebhookController < ApplicationController
  protect_from_forgery except: :index

  def index
    payload = request.body.read
    event = nil

    # Verify webhook signature and extract the event
    # See https://stripe.com/docs/webhooks/signatures for more information.
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      respond(400)
    rescue Stripe::SignatureVerificationError => e
      respond(400)
    end

    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']
      handle_checkout_session(session)
    end

    respond(200)
  end

  private

  def respond(status_code)
    head status_code
  end

  def handle_checkout_session(session)
    @ticket = Ticket.where(
      status: :claimed,
      stripe_checkout_session_id: session['client_reference_id'],
    ).first

    @ticket.sell!
  end

  def endpoint_secret
    @endpoint_secret ||= Rails.application.credentials.stripe[:endpoint_secret]
  end
end
