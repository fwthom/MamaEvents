class Event < ApplicationRecord
  belongs_to :charity
  has_many :tickets
  has_many :options, through: :tickets
  has_many :participants
end
