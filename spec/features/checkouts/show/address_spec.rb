RSpec.describe 'Checkouts show address page', type: :feature, js: true do
  let(:user) { create(:user, :with_cart, aasm_state: :address) }
  let(:address_attributes) { attributes_for(:address) }

  before do
    sign_in(user)
    visit checkout_path
  end

  context 'when address is valid' do
    let(:address) { create(:address, :billing).type }

    include_context 'when in checkout fill address valid'
    before do
      page.find('span.checkbox-icon').click
      click_button(I18n.t('checkout.save_continue'))
    end

    it 'redirects to the next state' do
      expect(page).to have_selector('h3', text: I18n.t('checkout.delivery.delivery'))
    end
  end

  context 'when address is invalid' do
    before do
      click_button(I18n.t('checkout.save_continue'))
    end

    it 'shows errors' do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end
  end
end
