RSpec.describe 'Orders index page', type: :feature, js: true do
  let(:user) { create(:user) }

  let!(:delivery_order) { create(:cart, user: user, aasm_state: :delivery) }
  let!(:delivered_orders) { create(:cart, user: user, aasm_state: :delivered) }

  describe '#index' do
    before do
      sign_in(user)
      visit orders_path
    end

    it { expect(page).to have_content(delivery_order.aasm_state.humanize) }
    it { expect(page).to have_content(delivered_orders.aasm_state.humanize) }

    context 'when using filter' do
      before do
        within 'div.dropdowns.dropdown.general-order-dropdown' do
          click_link(I18n.t('orders.all'))
          click_link(I18n.t('orders.states.delivery'))
        end
      end

      it { expect(page).to have_content(delivery_order.aasm_state.humanize) }
      it { expect(page).not_to have_content(delivered_orders.aasm_state.humanize) }
    end
  end
end
