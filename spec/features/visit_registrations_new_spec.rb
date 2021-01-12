RSpec.describe 'new devise registration', type: :feature do
  let(:new_user_info) { attributes_for(:user) }

  before do
    visit new_user_registration_path
  end

  context 'with correct input' do
    before do
      fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: new_user_info[:email])
      fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: new_user_info[:password])
      fill_in(I18n.t('simple_form.placeholders.defaults.password_confirmation'), with: new_user_info[:password])
      click_button(I18n.t('session.sign_up'))
    end

    it { expect(page).to have_current_path(root_path) }

    it 'saves user in database' do
      user = User.find_by(email: new_user_info[:email])
      expect(user).not_to be_nil
    end
  end

  context 'with incorrect input' do
    let(:wrong_email) { 'wronglol' }
    let(:wrong_password) { 'b123' }
    let(:activerecord_locale) { 'activerecord.errors.models.user.attributes' }

    before do
      fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: wrong_email)
      fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: wrong_password)
      fill_in(I18n.t('simple_form.placeholders.defaults.password_confirmation'), with: wrong_password.reverse)
      click_button(I18n.t('session.sign_up'))
    end

    it 'stays at sign up page' do
      expect(page).to have_current_path(user_registration_path)
    end

    it 'shows invalid email error' do
      expect(page).to have_content(I18n.t("#{activerecord_locale}.email.invalid"))
    end

    it 'shows invalid password error' do
      expect(page).to have_content(I18n.t("#{activerecord_locale}.password.invalid"))
    end

    it 'show too short password error' do
      expect(page).to have_content(I18n.t("#{activerecord_locale}.password.too_short"))
    end

    it 'shows invalid confirmation password message' do
      expect(page).to have_content(I18n.t("#{activerecord_locale}.password_confirmation.confirmation"))
    end
  end
end
