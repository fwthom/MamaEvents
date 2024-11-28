class MakePaymentOptionalInDonations < ActiveRecord::Migration[7.1]
  def change
    change_column_null :donations, :payment_id, true
  end
end
