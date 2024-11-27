class CreateJoinTableTicketsOptions < ActiveRecord::Migration[7.1]
  def change
    create_join_table :tickets, :options do |t|
      t.index [:ticket_id, :option_id], unique: true
      t.index [:option_id, :ticket_id]
    end
  end
end
