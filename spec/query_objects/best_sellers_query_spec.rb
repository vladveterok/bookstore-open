RSpec.describe BestSellersQuery do
  let(:cart) { create(:cart, aasm_state: :delivered) }
  let(:line_item) { create(:line_item, cart: cart) }
  let(:best_book_01) { create(:book, :with_line_items_delivered) }
  let(:best_book_02) { create(:book, :with_line_items_delivered) }
  let(:best_book_03) { create(:book, :with_line_items_delivered) }
  let(:best_book_04) { create(:book, :with_line_items_delivered) }

  it 'returns best selled books' do
    best_books = [best_book_01, best_book_02, best_book_03, best_book_04]
    expect(Book.best_sellers.sort_by(&:id)).to eq best_books
  end
end
