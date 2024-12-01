class Event < ApplicationRecord
  belongs_to :charity
  has_many :tickets, dependent: :destroy
  has_many :options, dependent: :destroy
  has_many :participants, dependent: :destroy
end
