RSpec.describe OrdersPresenter do
  subject(:orders_presenter) { described_class.new(orders: orders, params: params) }

  let(:orders) { Cart.all }

  describe '#current_filter' do
    context 'when filter selected' do
      let(:params) { { filter: OrdersPresenter::STATES[0].to_s } }

      it { expect(orders_presenter.current_filter).to eq(I18n.t("orders.states.#{OrdersPresenter::STATES[0]}")) }
    end

    context 'when no filter selected' do
      let(:params) { { filter: nil } }

      it { expect(orders_presenter.current_filter).to eq I18n.t('orders.all') }
    end
  end
end
