RSpec.describe 'Orders show page', type: :feature, js: true do
  let(:user) { create(:user, :with_cart, aasm_state: :delivered) }
  let!(:billing_address) { create(:address, :billing, user: user) }
  let!(:shipping_address) { create(:address, :shipping, user: user) }

  before do
    sign_in(user)
    user.carts.last.bank_card = create(:bank_card)
    visit order_path(user.carts.last)
  end

  it { expect(page).to have_content(billing_address.address) }
  it { expect(page).to have_content(shipping_address.address) }
  it { expect(page).to have_content(user.carts.last.bank_card.expiration_date) }
  it { expect(page).to have_content(user.carts.last.delivery_method.name) }
end
