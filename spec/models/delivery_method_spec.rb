RSpec.describe DeliveryMethod, type: :model do
  context 'with table columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
    it { is_expected.to have_db_column(:days_min).of_type(:integer) }
    it { is_expected.to have_db_column(:days_max).of_type(:integer) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:days_min) }
    it { is_expected.to validate_presence_of(:days_max) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:days_min).is_greater_than(0) }

    it 'validates that days_max cannot be less than days_min' do
      error = 'Days max must be greater than or equal to 2'
      delivery_method = described_class.create(name: 'Foo', price: 1, days_min: 2, days_max: 1)
      expect(delivery_method.errors.full_messages.join).to eq(error)
    end
  end
end
