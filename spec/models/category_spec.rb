RSpec.describe Category, type: :model do
  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_many(:books).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:name) }
end
