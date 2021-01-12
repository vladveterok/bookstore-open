class CheckoutService
  attr_reader :errors

  STATES = {
    address: %i[update_address ship!],
    shipment: %i[find_delivery_method pay!],
    payment: %i[add_payment confirm!],
    confirmation: %i[confirm_checkout complete!]
  }.freeze

  def initialize(state:, params:, cart:)
    @state = state
    @params = params
    @cart = cart
    @errors = []
  end

  def call
    return @cart.queue! if @cart.completion?

    method(STATES[@state.to_sym][0]).call
    return if @errors.any?

    @cart.method(STATES[@state.to_sym][1]).call
  end

  private

  def update_address
    @cart.user.billing_address&.update(@params[:billing_address]) || create_address(@params[:billing_address])
    @cart.user.shipping_address&.update(shipping_address) || create_address(shipping_address)
  end

  def create_address(params)
    address = Address.create(user_id: @cart.user.id, **params)
    @errors.push address.errors.full_messages unless address.valid?
  end

  def shipping_address
    @params[:use_billing] ? @params[:billing_address].merge(type: 'ShippingAddress') : @params[:shipping_address]
  end

  def find_delivery_method
    delivery_method = DeliveryMethod.find_by(id: @params[:delivery_method_id])
    @cart.update(delivery_method: delivery_method)
  end

  def add_payment
    @cart.bank_card ? @cart.bank_card.update(@params[:bank_card]) : create_card
  end

  def confirm_checkout
    finalize_order
    OrderMailer.order_confirmation_mail(@cart).deliver
  end

  def create_card
    card = BankCard.new(cart: @cart, **@params[:bank_card])
    @errors.push card.errors.full_messages unless card.valid?
  end

  def finalize_order
    cart = CartDecorator.decorate(@cart)
    cart.update(ordered_subtotal: cart.subtotal,
                ordered_discount: cart.discount,
                ordered_total: cart.total_with_delivery)
  end
end
