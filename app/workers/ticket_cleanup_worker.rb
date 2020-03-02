class TicketCleanupWorker
  include Sidekiq::Worker

  def perform(ticket_id)
    @ticket = Ticket.find(ticket_id)

    return if @ticket.status == "sold"

    @ticket.cleanup!
  end
end
