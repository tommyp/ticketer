class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :guid, null: false
      t.index :guid, unique: true
      t.references :event, null: false, foreign_key: true
      t.integer :status, default: 0
      t.string :name, null: true
      t.index :name, unique: true

      t.timestamps
    end
  end
end
