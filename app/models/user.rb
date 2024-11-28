class User < ApplicationRecord
  validates :role, presence: true, inclusion: { in: %w[admin volunteer] }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
