class SortedBooksQuery
  SORT_PARAMS = { 'newest' => { created_at: :desc },
                  'popular' => { created_at: :desc },
                  'price_lowtohight' => :price,
                  'price_highttolow' => { price: :desc },
                  'az' => :title,
                  'za' => { title: :desc } }.freeze

  class << self
    delegate :call, to: :new
  end

  def initialize(relation = Book)
    @relation = relation
  end

  def call(sort_param)
    @relation.order(sort_by(sort_param))
  end

  def sort_by(params)
    sort_params[params] || sort_params['newest']
  end

  def sort_params
    SORT_PARAMS
  end
end
