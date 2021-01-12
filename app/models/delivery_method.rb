class DeliveryMethod < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :days_min, presence: true, numericality: { greater_than: 0 }
  validates :days_max, presence: true, numericality: { greater_than_or_equal_to: :days_min }
end
