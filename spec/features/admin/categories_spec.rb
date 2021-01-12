RSpec.describe 'admin Categories', type: :feature do
  let(:admin_user) { create(:admin_user) }
  let!(:category) { create(:category) }

  before do
    sign_in(admin_user)
  end

  describe '#index' do
    before do
      visit admin_categories_path
    end

    it 'shows name' do
      expect(page).to have_content(category.name)
    end
  end

  describe '#create' do
    let(:category_attributes) { attributes_for(:category) }

    before do
      visit new_admin_category_path
      fill_in('category_name', with: category_attributes[:name])
      click_button('commit')
    end

    it 'creates new category' do
      expect(page).to have_current_path(admin_category_path(Category.last))
    end
  end
end
