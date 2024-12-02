class RenamePresentToRemoteInTickets < ActiveRecord::Migration[7.1]
  def change
    rename_column :tickets, :present, :remote
  end
end
