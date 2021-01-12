RSpec.describe SortedBooksQuery do
  let(:books) { create_list(:book, 5) }

  context 'when sorting' do
    SortedBooksQuery::SORT_PARAMS.each do |sort_key, sort_value|
      it "sorts books by #{sort_key}" do
        sorted_books = Book.order(sort_value)
        expect(Book.sorted(sort_key)).to eq sorted_books
      end
    end
  end
end
