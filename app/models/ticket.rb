class Ticket < ApplicationRecord
  belongs_to :event
  has_many :participations
  has_and_belongs_to_many :options

  validates :name, presence: true
  validates :unit_price, presence: true
end