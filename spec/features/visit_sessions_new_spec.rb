RSpec.describe 'new devise session', type: :feature do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  context 'with correct input' do
    it 'redirects to root_path' do
      fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: user.email)
      fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: user.password)
      click_button(I18n.t('session.sign_in_btn'))

      expect(page).to have_current_path(root_path)
    end
  end

  context 'with incorrect input' do
    let(:wrong_password) { FFaker::Internet.password(9, 16).delete('_') }

    before do
      fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: user.email)
      fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: wrong_password)
      click_button(I18n.t('session.sign_in_btn'))
    end

    it 'stays on log in page' do
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'shows error message' do
      expect(page).to have_content(I18n.t('devise.failure.not_found_in_database', authentication_keys: 'Email'))
    end
  end
end
