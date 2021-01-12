RSpec.describe 'new devise password', type: :feature do
  before do
    visit new_user_password_path
  end

  context 'when email is registered' do
    let(:user) { create(:user) }

    before do
      fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: user.email)
      click_button(I18n.t('session.email_instructions_btn'))
    end

    it { expect(page).to have_content(I18n.t('devise.passwords.send_instructions')) }
    it { expect(page).to have_current_path(new_user_session_path) }
  end

  context 'when email is not registered' do
    let(:wrong_email) { FFaker::Internet.email }

    before do
      fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: wrong_email)
      click_button(I18n.t('session.email_instructions_btn'))
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_found')) }
    it { expect(page).to have_current_path(user_password_path) }
  end
end
