class CartDecorator < MyDecorator
  QUNTITY_OF_ORDER_NUMBERS = 5**5

  def add_item(params)
    current_item(params) ? update(current_item(params), params) : line_items.create(params)
  end

  def items_quantity
    blank? ? Constants::LINE_ITEMS_QUANTITY : line_items&.sum(&:quantity)
  end

  def subtotal
    LineItemDecorator.decorate(line_items.with_book).sum(&:subtotal)
  end

  def discount
    subtotal / 100 * (coupon&.discount || Constants::DEFAULT_DISCOUNT)
  end

  def delivery_cost
    delivery_method&.price || Constants::DEFAULT_COST
  end

  def total
    subtotal - discount
  end

  def total_with_delivery
    total + delivery_cost
  end

  def order_number
    "#R#{id}#{user.id}#{line_items.map(&:id).join}"
  end

  def order_date
    I18n.l(updated_at, format: :order_date)
  end

  def complete_date
    completed_at ? I18n.l(completed_at, format: :order_date) : I18n.t('orders.not_completed')
  end

  private

  def current_item(params)
    line_items.find_by(book_id: params[:book_id])
  end

  def update(item, params)
    item.update(quantity: item.quantity + params[:quantity].to_i)
  end
end
