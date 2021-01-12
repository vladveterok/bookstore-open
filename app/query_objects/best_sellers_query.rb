class BestSellersQuery
  LIMIT = 4

  class << self
    delegate :call, to: :new
  end

  def initialize(relation = Book)
    @relation = relation
  end

  def call
    @relation.with_authors
             .limit(LIMIT)
             .left_joins(line_items: :cart)
             .merge(Cart.sold).group(:id)
             .order('COUNT(line_items.id) DESC')
  end
end
