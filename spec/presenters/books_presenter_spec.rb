RSpec.describe BooksPresenter do
  subject(:books_presenter) { described_class.new(books: books, params: params, categories: Category.all) }

  let(:number_of_books_and_categories) { 15 }
  let(:all_categories) { I18n.t('catalog.filter.all_books') }
  let(:books) { build_list(:book, number_of_books_and_categories) }
  let(:categories) { create_list(:category, number_of_books_and_categories) }

  describe '#current_sort' do
    SortedBooksQuery::SORT_PARAMS.each_key do |key|
      context "with #{key} sorting selected" do
        let(:params) { { sort: key } }

        it "returns #{key} sorting" do
          expect(books_presenter.current_sort).to eq(key.to_sym)
        end
      end
    end

    context 'with no sorting selected' do
      let(:params) { { sort: nil } }

      it 'returns "newest" sorting' do
        expect(books_presenter.current_sort).to eq(:newest)
      end
    end
  end

  describe '#current_category' do
    context 'with category selected' do
      let(:params) { { category: categories.first.id } }

      it 'returns selected category' do
        expect(books_presenter.current_category).to eq(categories.first.name)
      end
    end

    context 'with no category selected' do
      let(:params) { { category: nil } }

      it 'returns "All"' do
        expect(books_presenter.current_category).to eq(all_categories)
      end
    end
  end
end
