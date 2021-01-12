RSpec.describe Author, type: :model do
  context 'with associations' do
    it { is_expected.to have_many(:author_books).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:author_books) }
  end

  context 'with table columns' do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
  end

  context 'with validations' do
    let(:invalid_name) { '123' }
    let(:min_length) { Constants::NAME_LENGTH.min }
    let(:max_length) { Constants::NAME_LENGTH.max }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_length_of(:first_name).is_at_least(min_length) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(max_length) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(min_length) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(max_length) }
    it { is_expected.not_to allow_value(invalid_name).for(:first_name) }
    it { is_expected.not_to allow_value(invalid_name).for(:last_name) }
  end
end
