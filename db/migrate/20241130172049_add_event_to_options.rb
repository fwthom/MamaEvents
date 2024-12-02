class AddEventToOptions < ActiveRecord::Migration[7.1]
  def change
    add_reference :options, :event, null: false, foreign_key: true
  end
end
