RSpec.describe 'admin Books', type: :feature do
  let(:admin_user) { create(:admin_user) }
  let!(:book) { BookDecorator.decorate(create(:book)) }

  before do
    sign_in(admin_user)
  end

  describe '#index' do
    before do
      visit admin_books_path
    end

    it 'shows title' do
      expect(page).to have_content(book.title)
    end

    it 'shows price' do
      expect(page).to have_content(book.price)
    end

    it 'shows category' do
      expect(page).to have_content(book.category.name)
    end

    it 'shows authors' do
      expect(page).to have_content(book.all_authors)
    end
  end

  describe '#create' do
    let!(:category) { create(:category) }
    let!(:author) { create(:author) }
    let(:book_attributes) { attributes_for(:book) }

    before do
      visit new_admin_book_path
      page.select(category.name, from: 'book_category_id')
      fill_in('book_title', with: book_attributes[:title])
      check("book_author_ids_#{author.id}")
      fill_in('book_description', with: book_attributes[:description])
      fill_in('book_price', with: book_attributes[:price])
      click_button('commit')
    end

    it 'creates new book' do
      expect(page).to have_current_path(admin_book_path(Book.last))
    end
  end
end
