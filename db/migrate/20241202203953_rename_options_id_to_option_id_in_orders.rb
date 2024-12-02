class RenameOptionsIdToOptionIdInOrders < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :options_id, :option_id
  end
end
