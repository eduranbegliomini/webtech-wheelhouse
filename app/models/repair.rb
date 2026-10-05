class Repair < ApplicationRecord
  belongs_to :bike
  belongs_to :employee, optional: true
  has_many :repair_services, dependent: :destroy
  has_many :services, through: :repair_services

  accepts_nested_attributes_for :repair_services, reject_if: proc { |attrs| attrs['service_id'].blank? }, allow_destroy: true

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

  has_rich_text :diagnosis
  
  has_many_attached :intake_photos do |attachable|
    attachable.variant :thumb, resize_to_fill: [100, 100]
    attachable.variant :large, resize_to_limit: [600, 600]
  end

  validates :state, presence: true
  validate :dates_are_logical
  validate :status_logic
  validate :acceptable_intake_photos 

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

  def acceptable_intake_photos
    return unless intake_photos.attached?
    
    acceptable_types = ["image/jpeg", "image/png"]
    
    intake_photos.each do |photo|
      unless photo.byte_size <= 5.megabytes
        errors.add(:intake_photos, "'#{photo.filename}' is too big (limit is 5MB)")
      end

      unless acceptable_types.include?(photo.content_type)
        errors.add(:intake_photos, "'#{photo.filename}' must be a JPEG or PNG")
      end
    end
  end

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