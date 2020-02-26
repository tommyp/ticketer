class AddStripeInfoToTicket < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :stripe_checkout_session_id, :string
    add_column :tickets, :stripe_confirmed, :boolean
    add_column :tickets, :stripe_confirmed_at, :datetime
  end
end
