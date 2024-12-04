class AddDefaultToRemoteInTickets < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tickets, :remote, false
  end
end
