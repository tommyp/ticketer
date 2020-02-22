class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :available_tickets_count
      t.integer :claimed_tickets_count
      t.integer :sold_tickets_count

      t.timestamps
    end
  end
end
