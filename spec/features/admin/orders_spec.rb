RSpec.describe 'admin Orders', type: :feature do
  let(:admin_user) { create(:admin_user) }
  let(:user) { create(:user) }
  let(:order) { create(:cart, aasm_state: :queue, user: user) }
  let(:line_items) { create_list(:line_item, 2, cart: order) }
  let(:decorated_order) { CartDecorator.decorate(order) }

  before do
    line_items
    sign_in(admin_user)
    visit admin_orders_path
  end

  it { expect(page).to have_content(decorated_order.order_number) }
  it { expect(page).to have_content(decorated_order.order_date) }
  it { expect(page).to have_content(decorated_order.aasm_state.humanize) }
end
