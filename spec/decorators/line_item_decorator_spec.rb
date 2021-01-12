RSpec.describe LineItemDecorator do
  include_context 'when create cart with items'

  let(:delivery_method) {}
  let(:decorated_line_item) { described_class.decorate(line_item) }

  describe '#book_item' do
    it 'returns book' do
      expect(decorated_line_item.book_item).to eq(book_with_images)
    end
  end

  describe 'subtotal' do
    it 'returns subtotal of books in line_items' do
      subtotal = decorated_line_item.book.price * decorated_line_item.quantity
      expect(decorated_line_item.subtotal).to eq subtotal
    end
  end
end
