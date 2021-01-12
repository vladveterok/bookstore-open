RSpec.describe BankCardDecorator do
  let(:bank_card) { create(:bank_card) }

  describe '#last_numbers' do
    it 'returns last 4 numbers of card' do
      last_numbers = bank_card.number[-4..].to_s
      expect(described_class.decorate(bank_card).last_numbers).to eq last_numbers
    end
  end
end
