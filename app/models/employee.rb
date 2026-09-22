class Employee < ApplicationRecord
  has_many :repairs, dependent: :nullify

  validates :name, :role, presence: true

  scope :by_role_and_name, -> { order(:role, :name) }
end