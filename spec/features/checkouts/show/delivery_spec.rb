RSpec.describe 'Checkouts show delivery page', type: :feature, js: true do
  let(:user) { create(:user, :with_cart, aasm_state: :shipment) }
  let!(:delivery_methods) { create_list(:delivery_method, 2) }

  before do
    sign_in(user)
    visit checkout_path
  end

  context 'when on delivery page' do
    it 'shows deliveries on page' do
      delivery_methods.map(&:name).each do |name|
        expect(page).to have_content(name)
      end
    end
  end

  context 'when user chooses delivery' do
    before do
      within 'div.hidden-xs.mb-res-50' do
        page.all('span.radio-icon').first.click
        click_button(I18n.t('checkout.save_continue'))
      end
    end

    it 'redirects to the next state' do
      expect(page).to have_selector('h3', text: I18n.t('checkout.payment.credit_card'))
    end
  end
end
