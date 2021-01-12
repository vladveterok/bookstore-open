RSpec.describe BankCard, type: :model do
  context 'with assosiations' do
    it { is_expected.to belong_to(:cart) }
  end

  context 'with table columns' do
    it { is_expected.to have_db_column(:number).of_type(:string) }
    it { is_expected.to have_db_column(:expiration_date).of_type(:string) }
    it { is_expected.to have_db_column(:cvv).of_type(:string) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:expiration_date) }
    it { is_expected.to validate_presence_of(:cvv) }
    it { is_expected.to validate_presence_of(:name) }
  end
end
