RSpec.describe 'OmniauthCallbacks', type: :request do
  let(:callback) { Faker::Omniauth.facebook }

  before do
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(callback)
  end

  context 'when user exists' do
    before do
      create(:user, uid: callback[:uid])
    end

    it 'redirects to root path' do
      post user_facebook_omniauth_callback_path(callback)
      expect(response).to redirect_to(root_path)
    end

    it 'does not create new user' do
      expect { post user_facebook_omniauth_callback_path(callback) }.not_to(change { User.all.count })
    end
  end

  context 'when user is new' do
    it 'redirects to root path' do
      post user_facebook_omniauth_callback_path(callback)
      expect(response).to redirect_to(root_path)
    end

    it 'creates new user' do
      expect { post user_facebook_omniauth_callback_path(callback) }.to(change { User.all.count }) # .by(1)
    end
  end
end
