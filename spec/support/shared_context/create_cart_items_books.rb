RSpec.shared_context 'when create cart with items' do
  let(:book) { create(:book, price: 100) }
  let(:book_with_images) { create(:book, :with_images, price: 100) }
  let(:coupon) { create(:coupon) }
  let(:cart) { create(:cart, coupon: coupon, delivery_method: delivery_method) }
  let(:line_item) { create(:line_item, book: book_with_images, cart: cart) }
  let(:line_items) { create_list(:line_item, 2, book: book, cart: cart) }
end
