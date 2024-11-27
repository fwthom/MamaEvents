class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.date :date
      t.string :location
      t.references :charity, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
