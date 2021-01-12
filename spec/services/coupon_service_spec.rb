RSpec.describe CouponService do
  let(:cart) { create(:cart) }

  describe '#apply_coupon' do
    subject(:coupon_service) { described_class.apply_coupon(code: code, cart: cart) }

    let(:coupon_attributes) { attributes_for(:coupon) }
    let(:code) { coupon_attributes[:code] }

    context 'with valid code' do
      let!(:coupon) { create(:coupon, code: code) }

      it 'adds coupon id to cart' do
        expect { coupon_service }.to change(cart, :coupon_id).from(nil).to(coupon.id)
      end

      it 'changes status of coupon' do
        coupon_service
        expect(coupon.reload.coupon_status).to eq 'used'
      end
    end

    context 'with invalid code' do
      let(:wrong_code) { "#{coupon_attributes[:code]}foobar" }
      let!(:coupon) { create(:coupon, code: wrong_code) }

      it 'does not add coupon id to cart' do
        expect { coupon_service }.not_to change(cart, :coupon_id)
      end

      it 'does not change status of coupon' do
        coupon_service
        expect(coupon.reload.coupon_status).to eq 'unused'
      end
    end

    context 'with used coupon' do
      let(:coupon) { create(:coupon, code: code, status: :used) }

      it 'does not add coupon id to cart' do
        expect { coupon_service }.not_to change(cart, :coupon_id)
      end
    end
  end
end
