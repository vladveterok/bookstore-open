RSpec.describe FilteredBooksQuery do
  let(:books) { create_list(:book, 5) }

  context 'when filtering' do
    let(:picked_category) { books.sample.category }

    it 'shows queried category' do
      books_with_category = books.select { |book| book.category == picked_category }
      expect(books_with_category).to eq Book.filtered(picked_category)
    end
  end

  context 'when not filtering' do
    let(:empty_category) { nil }

    it 'shows all books' do
      expect(books).to eq Book.filtered(empty_category)
    end
  end
end
