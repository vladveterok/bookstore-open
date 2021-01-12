class CheckoutsController < ApplicationController
  before_action :set_state, only: %i[show update]
  after_action :complete_checkout, only: %i[show]
  after_action :add_cart_to_user, only: %i[sign_up checkout_sign_in]

  ADDRESS_PARAMS = %i[first_name last_name address city zip country phone type].freeze
  CARD_PARAMS = %i[number expiration_date cvv name].freeze

  def show
    cancel if @cart.canceled?
  end

  def update
    checkout_service = CheckoutService.new(state: @state, params: cart_params, cart: @cart)
    checkout_service.call
    flash.alert = checkout_service.errors if checkout_service.errors.any?
    redirect_to checkout_path
  end

  def sign_up
    user = User.new(email: user_params[:email])
    user.define_singleton_method(:password_required?) { false }
    return redirect_to checkout_path, alert: I18n.t('checkout.login.user_already_exists') unless user.save

    sign_in(user)
    user.send_reset_password_instructions
    redirect_to checkout_path, notice: I18n.t('checkout.login.valid_user')
  end

  def checkout_sign_in
    user = User.find_by(email: user_params[:email])
    return redirect_to checkout_path, alert: I18n.t('checkout.login.invalid_user') unless valid_user?(user)

    sign_in(user)
    redirect_to checkout_path, notice: I18n.t('checkout.login.valid_user')
  end

  def complete_checkout
    return unless @cart&.completion?

    CheckoutService.new(state: @cart.aasm_state.to_sym, params: params, cart: @cart).call
  end

  def cancel
    session[:cart_id] = nil
  end

  private

  def valid_user?(user)
    user&.valid_password?(user_params[:password])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def cart_params
    params.require(:cart).permit(:use_billing, :delivery_method_id, :confirm_order, :complete_order,
                                 bank_card: CARD_PARAMS,
                                 billing_address: ADDRESS_PARAMS,
                                 shipping_address: ADDRESS_PARAMS)
  end

  def set_state
    if params[:state]
      @state = @cart&.aasm_state = params[:state]
      @cart.save!
    else
      @state = @cart&.aasm_state
    end
  end

  def add_cart_to_user
    return unless @cart && current_user

    current_user.carts << @cart
  end
end
