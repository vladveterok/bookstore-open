RSpec.describe LineItem, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:cart) }
  end

  context 'with table columns' do
    it { is_expected.to have_db_column(:book_id).of_type(:integer) }
    it { is_expected.to have_db_column(:cart_id).of_type(:integer) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
  end

  context 'with validation' do
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end
end
