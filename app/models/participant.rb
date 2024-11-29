class Participant < ApplicationRecord
  # belongs_to :team
  belongs_to :event
  has_many :participations
  has_many :tickets, through: :participations

  validates :first_name, presence: true
end
