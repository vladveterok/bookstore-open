RSpec.describe 'orders', type: :request do
  let(:user) { create(:user, :with_cart, aasm_state: :delivery) }

  describe '#index' do
    context 'when user signed in' do
      before do
        sign_in(user)
        get orders_path
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'shows orders#index page' do
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not signed in' do
      before do
        get orders_path
      end

      it 'redirects to root page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#show' do
    context 'when user signed in' do
      let(:order) do
        create(:cart, aasm_state: :delivery,
                      user: user,
                      delivery_method: create(:delivery_method),
                      bank_card: create(:bank_card))
      end
      let(:billing_address) { create(:address, :billing, user: user) }
      let(:shipping_address) { create(:address, :shipping, user: user) }

      before do
        billing_address
        shipping_address
        sign_in(user)
        get order_path(order)
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'shows orders#show page' do
        expect(response).to render_template(:show)
      end
    end

    context 'when user is not signed in' do
      before do
        get order_path(create(:cart))
      end

      it 'redirects to root page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
