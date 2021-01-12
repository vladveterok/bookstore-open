RSpec.describe 'Checkouts show completion page', type: :feature, js: true do
  let(:user) { create(:user, :with_cart, aasm_state: :completion) }
  let!(:billing_address) { create(:address, :billing, user: user) }

  before do
    sign_in(user)
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
end
