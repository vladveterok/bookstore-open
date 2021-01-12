class OrdersController < ApplicationController
  def index
    return redirect_to root_path unless user_signed_in?

    orders = Cart.filtered(user: current_user, state: params[:filter])
    @presenter = OrdersPresenter.new(orders: orders, params: params)
  end

  def show
    return redirect_to root_path unless user_signed_in? && order

    @order = CartDecorator.decorate(order)
  end

  private

  def order
    Cart.find_by(id: params[:id])
  end
end
