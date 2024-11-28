class Donation < ApplicationRecord
  has_one :payment, as: :payable
  validates :first_name, :last_name, :address, :postal_code, :amount, presence: true
end
