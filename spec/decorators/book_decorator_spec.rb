RSpec.describe BookDecorator do
  let(:decorated_book) { described_class.decorate(build(:book)) }

  describe '#all_authors' do
    it 'returns concatenated name and last name' do
      full_name = AuthorDecorator.decorate(decorated_book.authors.first).full_name
      expect(decorated_book.all_authors).to eq full_name
    end
  end

  describe '#short_description' do
    let(:description_max_length) { described_class::SHORT_DESCRIPTION_MAX_LENGTH }
    let(:invalid_length) { description_max_length + 50 }

    before do
      decorated_book.description = 'a' * invalid_length
    end

    it 'truncates description' do
      expect(decorated_book.short_description.length).to eq description_max_length
    end
  end

  describe '#dimensions' do
    it 'returns dimensions of a book' do
      book_dimensions = I18n.t('show.dimensions.dimensions', height: decorated_book.height,
                                                             width: decorated_book.width,
                                                             depth: decorated_book.depth).to_s
      expect(decorated_book.dimensions).to eq book_dimensions
    end
  end
end
