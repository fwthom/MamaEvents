class Participation < ApplicationRecord
  belongs_to :participant
  belongs_to :ticket
  belongs_to :payment, optional: true

  validates :token, presence: true
  validates :status, presence: true

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
