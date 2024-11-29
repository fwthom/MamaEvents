class MakePaymentIdOptionalInParticipations < ActiveRecord::Migration[7.1]
  def change
    change_column_null :participations, :payment_id, true
  end
end
