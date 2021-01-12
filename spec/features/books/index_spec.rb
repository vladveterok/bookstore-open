RSpec.describe 'Books index page', type: :feature do
  context 'when on page' do
    let(:number_of_books_total) { 15 }
    let(:category) { create(:category) }
    let(:view_more_link) { I18n.t('catalog.view_more_btn') }

    before do
      create_list(:book, number_of_books_total, :with_images, category: category)
      visit books_path
    end

    it 'shows catalog header' do
      expect(page).to have_selector('.general-title-margin')
    end

    it 'shows book counters' do
      expect(page).to have_text(Book.all.count)
    end

    it 'shows number of books in category' do
      expect(page).to have_text(category.books.count)
    end

    it 'shows images' do
      expect(page).to have_css("img[src*='test_image']")
    end

    context 'when not pressing view_more link' do
      let(:number_of_books_per_page) { 12 }

      it 'shows 12 books' do
        expect(page).to have_selector('#book', count: number_of_books_per_page)
      end

      it 'shows view_more link' do
        expect(page).to have_content(view_more_link)
      end
    end

    context 'when pressing view_more link' do
      let(:number_books_on_new_page) { 3 }

      before { click_link(view_more_link) }

      it 'shows more books' do
        expect(page).to have_selector('#book', count: number_books_on_new_page)
      end

      it 'disables view_more link' do
        expect(page).not_to have_selector('next_link', text: view_more_link)
      end
    end
  end

  context 'when on page and filtering' do
    let!(:category) { create(:category) }
    let(:number_books_in_category) { 3 }
    let!(:category_books) { create_list(:book, number_books_in_category, :with_images, category: category) }
    let(:number_other_books) { 3 }
    let!(:other_books) { create_list(:book, number_other_books, :with_images) }

    before do
      visit books_path
      within('ul.list-inline.pt-10.mb-25.mr-240.list_of_categories') { click_link(category.name) }
    end

    it 'displays category books' do
      category_books.each do |book|
        expect(page).to have_content(book.title)
      end
    end

    it "doesn't display others books" do
      other_books.each do |book|
        expect(page).not_to have_content(book.title)
      end
    end
  end

  context 'when on page and sorting' do
    let(:number_of_books_per_page) { 12 }
    let(:books_amount) { 10 }

    let(:sorting_orders) do
      { I18n.t('catalog.sorting.price_lowtohight') => :price,
        I18n.t('catalog.sorting.price_highttolow') => { price: :desc },
        I18n.t('catalog.sorting.az') => :title,
        I18n.t('catalog.sorting.za') => { title: :desc } }
    end

    before do
      create_list(:book, number_of_books_per_page, :with_images)
      visit books_path
    end

    it 'newest books first' do
      books_titles = Book.order(created_at: :desc).map(&:title)
      displayed_titles = page.all('p.title').map(&:text)
      expect(books_titles).to eq displayed_titles
    end

    it 'displays books sorted' do
      sorting_orders.each do |sort_name, property|
        within('ul.dropdown-menu.list_of_sorting') { click_link(sort_name) }
        books_titles = Book.order(property).map(&:title)
        displayed_titles = page.all('p.title').map(&:text)
        expect(books_titles).to eq displayed_titles
      end
    end
  end
end
