RSpec.describe 'Checkouts show payment page', type: :feature, js: true do
  let(:user) { create(:user, :with_cart, aasm_state: :payment) }
  let(:bank_card_params) { attributes_for(:bank_card) }

  before do
    sign_in(user)
    visit checkout_path
  end

  context 'when input is valid' do
    before do
      Cart.last.delivery_method = create(:delivery_method)
      create(:address, :billing, user: user)
      create(:address, :shipping, user: user)

      fill_in(I18n.t('simple_form.placeholders.bank_card.number'), with: bank_card_params[:number])
      fill_in(I18n.t('simple_form.placeholders.bank_card.name'), with: bank_card_params[:name])
      fill_in(I18n.t('simple_form.placeholders.bank_card.expiration_date'), with: bank_card_params[:expiration_date])
      fill_in(I18n.t('simple_form.placeholders.bank_card.cvv'), with: bank_card_params[:cvv])
      click_button(I18n.t('checkout.save_continue'))
    end

    it 'redirects to the next state' do
      expect(page).to have_selector('h3', text: I18n.t('checkout.confirmation.payment_info'))
    end
  end

  context 'when input is invalid' do
    before do
      click_button(I18n.t('checkout.save_continue'))
    end

    it 'shows errors' do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end
  end
end
