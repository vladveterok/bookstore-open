RSpec.describe 'checkouts', type: :request do
  describe '#show' do
    let(:user) { create(:user, :with_cart) }

    before do
      sign_in(user)
      get checkout_path
    end

    it 'is successful' do
      expect(response).to be_successful
    end

    it 'shows checkouts#show page' do
      expect(response).to render_template(:show)
    end
  end

  describe '#checkout_sign_in' do
    before do
      post checkout_sign_in_path params: sign_in_params
    end

    context 'with valid input' do
      let(:user) { create(:user) }
      let(:sign_in_params) { { user: { email: user.email, password: user.password } } }

      it 'redirects to checkout page' do
        expect(response).to redirect_to(checkout_path)
      end
    end

    context 'with invalid input' do
      let(:sign_in_params) { { user: { email: '', password: '' } } }

      it 'redirects to checkout page' do
        expect(response).to redirect_to(checkout_path)
      end
    end
  end

  describe '#sign_up' do
    let(:email) { attributes_for(:user)[:email] }

    context 'with valid input' do
      before do
        get root_path
        post checkout_sign_up_path, params: { user: { email: email } }
      end

      it 'redirects to checkout page' do
        expect(response).to redirect_to(checkout_path)
      end
    end

    context 'with user already exists' do
      before do
        create(:user, email: email)
        post checkout_sign_up_path, params: { user: { email: email } }
      end

      it 'redirects to checkout page' do
        expect(response).to redirect_to(checkout_path)
      end

      it 'does not save new user' do
        expect { response }.not_to change(User.all, :count)
      end
    end
  end
end
