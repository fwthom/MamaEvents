class Option < ApplicationRecord
  has_and_belongs_to_many :tickets, optional: true
  belongs_to :event
end

