class FilteredOrdersQuery
  class << self
    delegate :call, to: :new
  end

  def initialize(relation = Cart)
    @relation = relation.with_user.with_coupon.with_items.with_delivery
  end

  def call(user:, state:)
    state ? @relation.where(user_id: user.id, aasm_state: state) : @relation.where(user_id: user.id)
  end
end
