class RemoveNullConstraintFromParticipants < ActiveRecord::Migration[7.1]
  def change
    change_column_null :participants, :team_id, true
  end
end
