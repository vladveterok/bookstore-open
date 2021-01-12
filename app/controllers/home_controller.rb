class HomeController < ApplicationController
  def index
    @latest_books = BookDecorator.decorate(Book.latest)
    @best_sellers = BookDecorator.decorate(Book.best_sellers)
  end
end
