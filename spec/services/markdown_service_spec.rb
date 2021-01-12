describe MarkdownService do
  describe '#render' do
    let(:text) { 'some text' }
    let(:expected_text) { "<p>#{text}</p>\n" }

    it 'returns text with html tags' do
      expect(described_class.render(text)).to eq(expected_text)
    end
  end
end
