RSpec.describe BookImageUploader do
  let(:uploader) { described_class.new(book, :image) }
  let(:book) { create(:book) }

  describe 'versions' do
    let(:path_to_image) { 'spec/support/fixtures/images/test_image.jpg' }

    before do
      described_class.enable_processing = true
      File.open(path_to_image) { |f| uploader.store!(f) }
    end

    context 'with the latest book version' do
      it 'scales down an image to be 250 pixels wide' do
        expect(uploader.latest_books).to have_width(250)
      end
    end

    context 'with the catalog version' do
      it 'scales down an image to be 156 pixels wide' do
        expect(uploader.catalog).to have_width(156)
      end
    end

    context 'with the preview version' do
      it 'scales down an image to be 172 pixels wide' do
        expect(uploader.preview).to have_width(172)
      end
    end

    context 'with the full version' do
      it 'scales down an image to be 550 pixels wide' do
        expect(uploader.full).to have_width(550)
      end
    end
  end

  describe '#default_url' do
    let(:default_url) { 'default_book.jpg' }

    it 'return default url' do
      expect(uploader.default_url).to match(default_url)
    end
  end
end
