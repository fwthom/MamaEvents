class AddTokenToParticipation < ActiveRecord::Migration[7.1]
  def change
    add_column :participations, :token, :string
  end
end
