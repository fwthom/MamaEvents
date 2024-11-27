class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :participation, null: false, foreign_key: true
      t.integer :quantity
      t.references :options, null: false, foreign_key: true

      t.timestamps
    end
  end
end
