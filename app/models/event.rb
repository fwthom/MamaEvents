class Event < ApplicationRecord
  STATUS_OPTIONS = ["brouillon", "publié", "en cours", "terminé", "annulé"]
  belongs_to :charity
  has_many :tickets, dependent: :destroy
  has_many :options, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :participations, through: :tickets
  has_many :orders, through: :participations
  has_one_attached :image
  validates :status, inclusion: { in: STATUS_OPTIONS }

  scope :brouillon, -> { where(status: "brouillon") }
  scope :publies, -> { where(status: "publié") }
  scope :annules, -> { where(status: "annulé") }
  scope :termines, -> { where(status: "terminé") }
  scope :en_cours, -> { where(status: "en cours") }
end
