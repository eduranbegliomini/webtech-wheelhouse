class Repair < ApplicationRecord
  belongs_to :bike
  belongs_to :employee, optional: true
  has_many :repair_services, dependent: :destroy
  has_many :services, through: :repair_services

  enum :state, {
    received: "Received",
    estimating: "Estimating",
    waiting_for_approval: "Waiting for Approval",
    approved: "Approved",
    declined: "Declined",
    in_progress: "In Progress",
    completed: "Completed",
    picked_up: "Picked Up"
  }

  validates :state, presence: true
  validate :dates_are_logical
  validate :status_logic

  scope :open_repairs, -> { where(handed_back_at: nil) }
  scope :overdue, -> { open_repairs.where("promised_on < ?", Date.current) }
  scope :newest_first, -> { order(promised_on: :desc) }

  def overdue?
    promised_on.present? && promised_on < Date.current && handed_back_at.nil?
  end

  def total
    repair_services.sum(:charged_price)
  end

  private

  def dates_are_logical
    arrival_date = created_at&.to_date || Date.current

    if handed_back_at.present? && handed_back_at.to_date < arrival_date
      errors.add(:handed_back_at, "cannot be before the day the bike arrived at the shop")
    end

    if promised_on.present? && promised_on < arrival_date
      errors.add(:promised_on, "cannot be before the day the bike arrived at the shop")
    end
  end

  def status_logic
    if !picked_up? && handed_back_at.present?
      errors.add(:handed_back_at, "must be empty if the bike has not been picked up by the customer yet")
    end

    if (approved? || declined? || in_progress? || completed? || picked_up?) && customer_answer.blank?
      errors.add(:customer_answer, "must be recorded for a repair in this stage of the process")
    end
  end
end