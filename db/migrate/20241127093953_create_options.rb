class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.string :name
      t.string :description
      t.string :category
      t.decimal :unit_price
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
