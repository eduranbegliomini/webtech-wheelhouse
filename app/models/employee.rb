class Employee < ApplicationRecord
  has_many :repairs, dependent: :nullify

  has_one :user, dependent: :restrict_with_error

  validates :name, :role, presence: true

  scope :by_role_and_name, -> { order(:role, :name) }
end