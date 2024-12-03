class Participation < ApplicationRecord
  belongs_to :participant
  belongs_to :ticket
  belongs_to :payment, optional: true
  has_many :orders, dependent: :destroy
end
