class LineItemDecorator < MyDecorator
  def book_item
    BookDecorator.decorate(book)
  end

  def subtotal
    book.price * quantity
  end
end
