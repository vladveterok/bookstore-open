RSpec.describe 'Devise registrations edit', type: :feature do
  let(:user) { create(:user) }
  let(:address_attributes) { attributes_for(:address) }

  before do
    sign_in(user)
    visit edit_user_registration_path
  end

  context 'with Billing Address' do
    let(:address) { create(:address, :billing).type }

    context 'with valid input' do
      include_context 'when fill_address_valid'

      it 'redirects too edit user registration path' do
        expect(page).to have_current_path(edit_user_registration_path)
      end

      it 'saves Billing Address' do
        expect(page).to have_field(I18n.t('simple_form.placeholders.defaults.first_name'),
                                   with: address_attributes[:first_name])
      end
    end

    context 'with invalid input' do
      let(:invalid_name) { 'name1' }

      include_context 'when fill_address_invalid'

      it 'does not update address' do
        expect(page).not_to have_field(I18n.t('simple_form.placeholders.defaults.first_name'), with: invalid_name)
      end
    end
  end

  context 'with Shipping Address' do
    let(:address) { create(:address, :shipping).type }

    context 'with valid input' do
      include_context 'when fill_address_valid'

      it 'redirects to edit user registration path' do
        expect(page).to have_current_path(edit_user_registration_path)
      end

      it 'saves Shipping Address' do
        expect(page).to have_field(I18n.t('simple_form.placeholders.defaults.first_name'),
                                   with: address_attributes[:first_name])
      end
    end

    context 'with invalid input' do
      let(:invalid_name) { 'name1' }

      include_context 'when fill_address_invalid'

      it 'does not update address' do
        expect(page).not_to have_field(I18n.t('simple_form.placeholders.defaults.first_name'), with: invalid_name)
      end
    end
  end

  context 'when changing email' do
    let(:wrong_email) { '' }

    before { click_on(I18n.t('session.edit.privacy_link')) }

    it 'has user email' do
      expect(page).to have_field(I18n.t('simple_form.placeholders.defaults.email'), with: user.email)
    end

    context 'with valid input' do
      before do
        within '#email_form' do
          fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: address_attributes[:email])
          click_button(I18n.t('helpers.submit.user.update'))
        end
      end

      it 'saves new email' do
        expect(page).to have_field(I18n.t('simple_form.placeholders.defaults.email'), with: address_attributes[:email])
      end
    end

    context 'with errors' do
      before do
        within '#email_form' do
          fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: wrong_email)
          click_button(I18n.t('helpers.submit.user.update'))
        end
      end

      it 'stays at users/edit page' do
        expect(page).to have_current_path(user_registration_path)
      end
    end
  end

  context 'when changing password' do
    let(:wrong_pass) { '123' }

    before { click_on(I18n.t('session.edit.privacy_link')) }

    context 'with valid input' do
      before do
        within '#password_form' do
          fill_in(I18n.t('simple_form.placeholders.defaults.current_password'), with: user.password)
          fill_in(I18n.t('simple_form.placeholders.user.edit.password'), with: '123456789Di')
          fill_in(I18n.t('simple_form.placeholders.user.edit.password_confirmation'), with: '123456789Di')
          click_button(I18n.t('helpers.submit.user.update'))
        end
      end

      it 'saves new password' do
        expect(page).to have_current_path(root_path)
      end
    end

    context 'with errors' do
      before do
        within '#password_form' do
          fill_in(I18n.t('simple_form.placeholders.user.edit.password'), with: wrong_pass)
          fill_in(I18n.t('simple_form.placeholders.user.edit.password_confirmation'), with: wrong_pass)
          click_button(I18n.t('helpers.submit.user.update'))
        end
      end

      it 'stays at users/edit page' do
        expect(page).to have_current_path(user_registration_path)
      end
    end
  end

  context 'when removing account' do
    it 'removes account' do
      click_on(I18n.t('session.edit.privacy_link'))
      find(:css, '.checkbox-icon').set(true)
      click_on(I18n.t('session.edit.address.remove_acc_btn'))
      expect(page).to have_content(I18n.t('devise.registrations.destroyed'))
    end
  end
end
