RSpec.describe FilteredOrdersQuery do
  let(:user) { create(:user) }
  let(:queue_order) { create(:cart, aasm_state: :queue, user: user) }
  let(:delivered_order) { create(:cart, aasm_state: :delivered, user: user) }

  context 'when filtering' do
    let(:state) { queue_order.aasm_state }

    it { expect(Cart.filtered(user: user, state: state)).to eq [queue_order] }
  end

  context 'when not filtering' do
    let(:state) { nil }

    it { expect(Cart.filtered(user: user, state: state)).to eq [queue_order, delivered_order] }
  end
end
