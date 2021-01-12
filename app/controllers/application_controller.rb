class ApplicationController < ActionController::Base
  helper_method :categories
  before_action :set_cart
  after_action :remove_card_from_session

  private

  def categories
    @categories ||= Category.all
  end

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id])
  end

  def remove_card_from_session
    session[:cart_id] = nil if @cart&.queue?
  end
end
