RSpec.describe 'registrations', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    get edit_user_registration_path
  end

  describe 'edit_user_registration_path' do
    it 'is successful' do
      expect(response).to be_successful
    end

    it 'shows registrations#edit' do
      expect(response).to render_template(:edit)
    end
  end
end
