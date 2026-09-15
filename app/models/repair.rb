class Repair < ApplicationRecord
  belongs_to :bike
  belongs_to :employee, optional: true
  has_many :repair_services
end