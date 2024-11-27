class Participation < ApplicationRecord
  belongs_to :participant
  belongs_to :ticket
  belongs_to :payment
end
