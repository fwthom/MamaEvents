class RemoveNotNullConstraintFromTicketIdInOptions < ActiveRecord::Migration[7.1]

  def change
    change_column_null :options, :ticket_id, true
  end
end
