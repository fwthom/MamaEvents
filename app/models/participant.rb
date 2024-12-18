class Participant < ApplicationRecord
  belongs_to :event
  has_many :participations
  has_many :tickets, through: :participations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/ }

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end
