class OrdersPresenter
  attr_reader :orders

  STATES = %i[queue delivery delivered canceled].freeze

  def initialize(orders:, params:)
    @orders = CartDecorator.decorate(orders)
    @params = params[:filter]
  end

  def current_filter
    @params ? state(@params) : I18n.t('orders.all')
  end

  def state(current)
    Cart.aasm.states.map(&:name).find { |state| state.to_s == current }.to_s.capitalize
  end
end
