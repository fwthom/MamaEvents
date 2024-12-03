class AddTokenToParticipant < ActiveRecord::Migration[7.1]
  def change
    add_column :participants, :token, :string
  end
end
