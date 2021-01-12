RSpec.describe 'admin Authors', type: :feature do
  let(:admin_user) { create(:admin_user) }
  let!(:author) { create(:author) }

  before do
    sign_in(admin_user)
  end

  describe '#index' do
    before do
      visit admin_authors_path
    end

    it 'shows first_name' do
      expect(page).to have_content(author.first_name)
    end

    it 'shows last_name' do
      expect(page).to have_content(author.last_name)
    end

    it 'shows description' do
      expect(page).to have_content(author.description)
    end
  end

  describe '#create' do
    let(:author_attributes) { attributes_for(:author) }

    before do
      visit new_admin_author_path
      fill_in('author_first_name', with: author_attributes[:first_name])
      fill_in('author_last_name', with: author_attributes[:last_name])
      click_button('commit')
    end

    it 'creates new author' do
      expect(page).to have_current_path(admin_author_path(Author.last))
    end
  end
end
