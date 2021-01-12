class LatestBooksQuery
  BOOKS_AMOUNT = 3

  class << self
    delegate :call, to: :new
  end

  def initialize(relation = Book.with_authors)
    @relation = relation
  end

  def call
    @relation.order(created_at: :desc).limit(BOOKS_AMOUNT)
  end
end
