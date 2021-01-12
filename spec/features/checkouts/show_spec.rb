RSpec.describe 'Checkouts show page', type: :feature do
  let(:book_with_images) { create(:book, :with_images) }
  let(:user) { create(:user) }

  before do
    visit book_path(book_with_images)
    page.all('.btn.btn-default.pull-right.general-position').first.click
    visit cart_path
    click_link I18n.t('cart.headers.checkout')
  end

  describe 'log in' do
    context 'when login successfully', js: true do
      it 'redirects to checkout_path' do
        expect(page).to have_current_path(checkout_path)
      end

      it 'shows success notice' do
        within(:css, '.login') do
          fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: user.email)
          fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: user.password)
          click_button(I18n.t('helpers.submit.user.submit'))
        end
        expect(page).to have_content(I18n.t('checkout.login.valid_user'))
      end
    end

    context 'when login unsuccessfully' do
      let(:wrong_email) { FFaker::Internet.email }

      before do
        within(:css, '.login') do
          fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: wrong_email)
          fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: user.password)
          click_button(I18n.t('helpers.submit.user.submit'))
        end
      end

      it 'redirects to checkout_path' do
        expect(page).to have_current_path(checkout_path)
      end

      it 'shows error' do
        expect(page).to have_content(I18n.t('checkout.login.invalid_user'))
      end
    end
  end

  describe 'email only registration', js: true do
    context 'with valid email' do
      let(:valid_email) { FFaker::Internet.email }

      it 'shows success message' do
        within(:css, '.registration') do
          fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: valid_email)
          click_button(I18n.t('helpers.submit.user.create'), wait: 1)
        end
        expect(page).to have_content(I18n.t('checkout.login.valid_user'))
      end
    end

    context 'with invalid data' do
      let(:invalid_email) { 'invalid' }

      it 'shows validation error' do
        within(:css, '.registration') do
          fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: invalid_email)
          click_button(I18n.t('helpers.submit.user.create'))
        end
        expect(page).to have_css('.invalid-feedback')
      end

      it 'shows message that user exists' do
        within(:css, '.registration') do
          fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: user.email)
          click_button(I18n.t('helpers.submit.user.create'))
        end
        expect(page).to have_content(I18n.t('checkout.login.user_already_exists'))
      end
    end
  end
end
