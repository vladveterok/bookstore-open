RSpec.describe 'Home index page', type: :feature do
  before do
    visit root_path
  end

  context 'when on home page' do
    let!(:books) { create_list(:book, 3, :with_images) }

    it 'shows Get Started button' do
      expect(page).to have_text('Get Started')
    end

    it { expect(page).to have_selector('.navbar-header') }
    it { expect(page).to have_selector('footer') }
    it { expect(page).to have_selector('#slider') }

    it 'show books in slider' do
      books.each do |book|
        visit root_path
        within '#slider.carousel.slide' do
          expect(page).to have_text(book.title)
        end
      end
    end

    it 'shows image in slider' do
      visit root_path
      within '#slider.carousel.slide' do
        expect(page).to have_css("img[src*='test_image']")
      end
    end
  end
end
