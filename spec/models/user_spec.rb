RSpec.describe User, type: :model do
  context 'with associations' do
    it { is_expected.to have_one(:billing_address).dependent(:destroy) }
    it { is_expected.to have_one(:shipping_address).dependent(:destroy) }
  end

  context 'with table columns' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
    it { is_expected.to have_db_column(:provider).of_type(:string) }
    it { is_expected.to have_db_column(:uid).of_type(:string) }
  end

  context 'with validations' do
    let(:bad_pass_01) { '12345678' }
    let(:bad_pass_02) { 'Aa1' }
    let(:bad_pass_03) { 'AaAaAaAa' }

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.not_to allow_value(bad_pass_01).for(:password) }
    it { is_expected.not_to allow_value(bad_pass_02).for(:password) }
    it { is_expected.not_to allow_value(bad_pass_03).for(:password) }
  end

  describe '#from_omniauth' do
    let(:auth) { OmniAuth::AuthHash.new(Faker::Omniauth.facebook) }

    it 'returns user from facebook' do
      user = described_class.from_omniauth(auth)
      expect(user.uid).to eq auth.uid
    end
  end
end
