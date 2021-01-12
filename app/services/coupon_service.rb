class CouponService
  class << self
    def apply_coupon(code:, cart:)
      coupon = Coupon.find_by(code: code)
      return if coupon.nil? || coupon.used?

      cart&.update(coupon_id: coupon.id)
      coupon.used!
    end
  end
end
