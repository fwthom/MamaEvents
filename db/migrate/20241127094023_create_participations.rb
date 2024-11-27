class CreateParticipations < ActiveRecord::Migration[7.1]
  def change
    create_table :participations do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.string :status
      t.references :payment, null: false, foreign_key: true
      t.decimal :total_amount

      t.timestamps
    end
  end
end
