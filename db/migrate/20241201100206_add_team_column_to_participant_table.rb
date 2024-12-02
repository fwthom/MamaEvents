class AddTeamColumnToParticipantTable < ActiveRecord::Migration[7.1]
  def change
    add_column :participants, :team, :string
  end
end
