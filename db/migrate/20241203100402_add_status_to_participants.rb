class AddStatusToParticipants < ActiveRecord::Migration[7.1]
  def change
    add_column :participants, :status, :string
  end
end
