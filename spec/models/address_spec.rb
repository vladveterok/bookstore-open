RSpec.describe Address, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'with table columns' do
    it { is_expected.to have_db_column(:type).of_type(:string) }
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:address).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:zip).of_type(:string) }
    it { is_expected.to have_db_column(:country).of_type(:string) }
    it { is_expected.to have_db_column(:phone).of_type(:string) }
  end

  context 'with validations' do
    context 'with presence of attribute' do
      %i[type first_name last_name address city zip country phone].each do |attribute|
        it { is_expected.to validate_presence_of(attribute) }
      end
    end

    context 'with length of attribute' do
      %i[first_name last_name address city zip phone].each do |attribute|
        it { is_expected.to validate_length_of(attribute) }
      end
    end

    context 'with invalid data' do
      let(:invalid_name) { '1nv*l1d' }

      %i[first_name last_name address city].each do |attribute|
        it { is_expected.not_to allow_value(invalid_name).for(attribute) }
      end

      %w[foo fo0 123456789* 12345678911].each do |wrong_data|
        it { is_expected.not_to allow_value(wrong_data).for(:zip) }
      end
    end
  end
end
