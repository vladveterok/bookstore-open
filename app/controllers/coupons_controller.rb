class CouponsController < ApplicationController
  def update
    coupon = CouponService.apply_coupon(code: coupon_params[:code], cart: @cart)
    coupon.nil? ? flash[:alert] = I18n.t('cart.coupon.not_applied') : flash[:notice] = I18n.t('cart.coupon.applied')
    redirect_to cart_path
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end
