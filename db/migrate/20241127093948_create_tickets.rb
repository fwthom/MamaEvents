class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :description
      t.decimal :unit_price
      t.boolean :present
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
