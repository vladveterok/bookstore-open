RSpec.describe AuthorDecorator do
  let(:decorated_author) { described_class.decorate(build(:author)) }

  it "returns author's full name" do
    full_name = "#{decorated_author.first_name} #{decorated_author.last_name}"
    expect(decorated_author.full_name).to eq full_name
  end
end
