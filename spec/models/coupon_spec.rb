RSpec.describe Coupon, type: :model do
  context 'with table columns' do
    it { is_expected.to have_db_column(:code).of_type(:string) }
    it { is_expected.to have_db_column(:discount).of_type(:integer) }
    it { is_expected.to have_db_column(:coupon_status).of_type(:string) }
  end

  context 'with validation' do
    it { is_expected.to validate_presence_of(:coupon_status) }
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:discount) }
    it { is_expected.to validate_numericality_of(:discount).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:discount).is_less_than_or_equal_to(100) }
  end
end
