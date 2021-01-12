RSpec.describe 'cart', type: :request do
  describe '#show' do
    before do
      get cart_path
    end

    it 'is successful' do
      expect(response).to be_successful
    end

    it 'shows books#index page' do
      expect(response).to render_template(:show)
    end
  end

  describe '#update' do
    let(:book) { build(:book) }

    before do
      put cart_path, params: { cart: { book_id: book.id } }
    end

    it 'redirects to books_path' do
      expect(response).to redirect_to(books_path)
    end
  end

  describe '#destroy' do
    let(:cart) { create(:cart) }
    let(:user) { create(:user, carts: [cart]) }
    let(:line_items) { create_list(:line_item, 2, cart: cart) }

    before do
      sign_in(user)
      delete(cart_path, params: { id: line_items.first.id })
    end

    it 'redirects to cart_path' do
      expect(response).to redirect_to(cart_path)
    end
  end
end
