RSpec.describe LatestBooksQuery do
  describe '#call' do
    let!(:books) { create_list(:book, 4) }

    it 'collects 3 latest books from db' do
      expect(described_class.call).to eq books.last(3).reverse
    end
  end
end
