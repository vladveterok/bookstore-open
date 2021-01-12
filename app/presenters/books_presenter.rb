class BooksPresenter
  attr_reader :params, :books

  def initialize(books: nil, params: nil, categories: nil)
    @books = BookDecorator.decorate(books)
    @params = params
    @categories = categories
  end

  def current_sort
    params[:sort]&.to_sym || :newest
  end

  def current_category
    params[:category] ? @categories.find(params[:category]).name : I18n.t('catalog.filter.all_books')
  end

  def sort_params
    SortedBooksQuery::SORT_PARAMS
  end
end
