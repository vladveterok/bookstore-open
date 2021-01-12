RSpec.describe 'Checkouts show confirmation page', type: :feature, js: true do
  let(:user) { create(:user, :with_cart, aasm_state: :confirmation) }
  let!(:billing_address) { create(:address, :billing, user: user) }
  let!(:shipping_address) { create(:address, :shipping, user: user) }

  before do
    sign_in(user)
    user.carts.last.bank_card = create(:bank_card)
    visit checkout_path
  end

  describe 'billing address' do
    it { expect(page).to have_content(billing_address.first_name) }
    it { expect(page).to have_content(billing_address.last_name) }
    it { expect(page).to have_content(billing_address.city) }
    it { expect(page).to have_content(billing_address.address) }
    it { expect(page).to have_content(billing_address.country) }
    it { expect(page).to have_content(billing_address.phone) }
  end

  describe 'shipping address' do
    it { expect(page).to have_content(shipping_address.first_name) }
    it { expect(page).to have_content(shipping_address.last_name) }
    it { expect(page).to have_content(shipping_address.city) }
    it { expect(page).to have_content(shipping_address.address) }
    it { expect(page).to have_content(shipping_address.country) }
    it { expect(page).to have_content(shipping_address.phone) }
  end

  describe 'delivery method' do
    it { expect(page).to have_content(user.carts.last.delivery_method.name) }
  end

  describe 'bank card' do
    it { expect(page).to have_content(user.carts.last.bank_card.number[-4..]) }
    it { expect(page).to have_content(user.carts.last.bank_card.expiration_date) }
  end

  it 'redirects to complete page' do
    click_link(I18n.t('checkout.confirmation.place_order'))
    expect(page).to have_content(I18n.t('checkout.completion.thanks'))
  end
end
