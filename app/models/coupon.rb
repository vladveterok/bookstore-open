class Coupon < ApplicationRecord
  enum coupon_status: { unused: 'unused', used: 'used' }

  validates :coupon_status, presence: true
  validates :code, presence: true
  validates :discount, presence: true
  validates :discount, numericality: { greater_than: Constants::DISCOUNT_MIN_MAX.first,
                                       less_than_or_equal_to: Constants::DISCOUNT_MIN_MAX.last }
end
