class FilteredBooksQuery
  class << self
    delegate :call, to: :new
  end

  def initialize(relation = Book)
    @relation = relation
  end

  def call(category_params)
    category_params ? @relation.where(category: category_params) : Book.all
  end
end
