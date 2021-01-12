class CartsController < ApplicationController
  before_action :create_cart, only: :update

  def show
    CartDecorator.decorate(@cart)
  end

  def update
    CartDecorator.decorate(@cart).add_item(cart_params)
    redirect_back fallback_location: books_path, notice: I18n.t('cart.notices.add_book')
  end

  def destroy
    @cart.line_items.find(params[:id]).destroy
    @cart.destroy if @cart.line_items.blank?
    redirect_back fallback_location: cart_path, notice: I18n.t('cart.notices.remove_book')
  end

  private

  def create_cart
    @cart ||= Cart.create
    session[:cart_id] = @cart.id
    add_cart_to_current_user
  end

  def add_cart_to_current_user
    return unless user_signed_in?

    current_user.carts << @cart
  end

  def cart_params
    params.require(:cart).permit(:book_id, :quantity)
  end
end
