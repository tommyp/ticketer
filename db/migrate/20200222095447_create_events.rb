class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :available_tickets_count, default: 0
      t.integer :claimed_tickets_count, default: 0
      t.integer :sold_tickets_count, default: 0

      t.timestamps
    end
  end
end
