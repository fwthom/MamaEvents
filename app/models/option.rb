class Option < ApplicationRecord
  CATEGORIES = ["Alimentaire", "Vestimentaire", "Goodies", "Autre"]
  has_and_belongs_to_many :tickets, optional: true
  has_many :orders, dependent: :destroy
  belongs_to :event

  validates :category, inclusion: { in: CATEGORIES }
  validates :category, presence: true
  validates :name, presence: true
  validates :unit_price, presence: true

  scope :alimentaire, -> { where(category: "Alimentaire") }
  scope :vestimentaire, -> { where(category: "Vestimentaire") }
  scope :autre, -> { where(category: "Autre") }
  scope :goodies, -> { where(category: "Goodies") }

end
