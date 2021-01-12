RSpec.describe CartDecorator do
  include_context 'when create cart with items'
  let(:decorated_cart) { described_class.decorate(cart) }

  before do
    decorated_cart.line_items = line_items
  end

  context 'with coupon' do
    let(:coupon) { create(:coupon, discount: 25) }
    let(:delivery_method) {}

    describe '#items_quantity' do
      it 'returns number of line_items' do
        expect(decorated_cart.items_quantity).to eq line_items.count
      end
    end

    describe '#subtotal' do
      it 'returns subtotal of cost of all line_items' do
        subtotal = decorated_cart.line_items.map { |item| item.book.price * item.quantity }.sum
        expect(decorated_cart.subtotal).to eq subtotal
      end
    end

    describe '#discount' do
      it 'returns the amount of discount' do
        discount = decorated_cart.subtotal / 100 * coupon.discount
        expect(decorated_cart.discount).to eq discount
      end
    end

    describe '#total' do
      it 'returns total price with discount' do
        total = decorated_cart.subtotal - decorated_cart.discount
        expect(decorated_cart.total).to eq total
      end
    end
  end

  context 'without coupon' do
    let(:coupon) {}
    let(:delivery_method) {}

    describe '#discount' do
      it 'returns zero discount' do
        expect(decorated_cart.discount).to eq 0
      end
    end

    describe '#total' do
      it 'returns totla price without discount' do
        expect(decorated_cart.total).to eq decorated_cart.subtotal
      end
    end
  end

  describe '#delivery_cost' do
    let(:coupon) {}

    context 'with delivery' do
      let(:delivery_method) { create(:delivery_method) }

      it 'returns delivery price' do
        expect(decorated_cart.delivery_cost).to eq delivery_method.price
      end
    end

    context 'without delivery' do
      let(:delivery_method) {}

      it 'returns zero' do
        expect(decorated_cart.delivery_cost).to eq 0
      end
    end
  end

  describe '#total_with_delivery' do
    let(:coupon) {}
    let(:delivery_method) { create(:delivery_method) }

    it 'returns total + delivery' do
      total_with_delivery = decorated_cart.total + decorated_cart.delivery_cost
      expect(decorated_cart.total_with_delivery).to eq total_with_delivery
    end
  end
end
