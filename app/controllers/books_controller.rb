class BooksController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, books = pagy_countless(Book.with_authors.filtered(params[:category]).sorted(params[:sort]))
    @presenter = BooksPresenter.new(books: books, params: params, categories: categories)
  end

  def show
    @book = BookDecorator.decorate(Book.find(params[:id]))
    @reviews = @book.reviews.with_user.approved
  end
end
