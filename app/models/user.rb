class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :employee, optional: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  enum :role, { owner: "owner", mechanic: "mechanic", counter: "counter" }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 10, message: "must be at least 10 characters long" }, allow_nil: true
end
