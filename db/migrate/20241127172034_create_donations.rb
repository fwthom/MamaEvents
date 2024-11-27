class CreateDonations < ActiveRecord::Migration[7.1]
  def change
    create_table :donations do |t|
      t.references :payment, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :postal_code
      t.string :city
      t.decimal :amount
      t.string :currency
      t.string :status

      t.timestamps
    end
  end
end
