RSpec.describe 'edit devise password', type: :feature do
  before do
    user = create(:user)
    raw  = user.send_reset_password_instructions

    visit edit_user_password_path(reset_password_token: raw)
  end

  context 'with correct new password' do
    let(:correct_password) { attributes_for(:user)[:password] }

    before do
      fill_in(I18n.t('simple_form.placeholders.user.edit.password'), with: correct_password)
      fill_in(I18n.t('simple_form.placeholders.user.edit.password_confirmation'), with: correct_password)
      click_button(I18n.t('session.change_pass_btn'))
    end

    it 'redirects to home page' do
      expect(page).to have_current_path(root_path)
    end
  end

  context 'with incorrect new password' do
    let(:incorrect_password) { '1234' }

    before do
      fill_in(I18n.t('simple_form.placeholders.user.edit.password'), with: incorrect_password)
      fill_in(I18n.t('simple_form.placeholders.user.edit.password_confirmation'), with: incorrect_password)
      click_button(I18n.t('session.change_pass_btn'))
    end

    it 'stays at change password page' do
      expect(page).to have_current_path(user_password_path)
    end

    it 'shows invalid password message' do
      expect(page).to have_content(I18n.t('activerecord.errors.models.user.attributes.password.invalid'))
    end
  end
end
