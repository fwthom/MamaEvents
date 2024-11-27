class AddPayableToPayments < ActiveRecord::Migration[7.1]
  def change
    add_reference :payments, :payable, polymorphic: true, null: true
  end
end
