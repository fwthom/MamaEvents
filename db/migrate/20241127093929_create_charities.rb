class CreateCharities < ActiveRecord::Migration[7.1]
  def change
    create_table :charities do |t|
      t.string :name
      t.string :description
      t.string :contact_email
      t.string :phone_number
      t.string :logo

      t.timestamps
    end
  end
end
