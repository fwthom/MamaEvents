class AddEventIdToParticipant < ActiveRecord::Migration[7.1]
  def change
    add_column :participants, :event_id, :integer
  end
end
