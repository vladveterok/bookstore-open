RSpec.describe Cart, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to belong_to(:coupon).optional }
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
  end

  context 'with table columns' do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:coupon_id).of_type(:integer) }
  end

  context 'with aasm' do
    subject(:cart) { build(:cart) }

    it { expect(cart).to transition_from(:confirmation).to(:address).on_event(:address) }
    it { expect(cart).to transition_from(:confirmation, :address).to(:shipment).on_event(:ship) }
    it { expect(cart).to transition_from(:confirmation, :shipment).to(:payment).on_event(:pay) }
    it { expect(cart).to transition_from(:payment).to(:confirmation).on_event(:confirm) }
    it { expect(cart).to transition_from(:confirmation).to(:completion).on_event(:complete) }
    it { expect(cart).to transition_from(:completion).to(:queue).on_event(:queue) }

    it { expect(cart).not_to transition_from(:confirmation).to(:queue).on_event(:address) }
  end
end
