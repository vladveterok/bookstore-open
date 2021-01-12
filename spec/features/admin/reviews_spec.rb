RSpec.describe 'admin Reviews', type: :feature do
  let(:admin_user) { create(:admin_user) }
  let!(:review) { create(:review) }

  before do
    sign_in(admin_user)
  end

  describe '#index' do
    before do
      visit admin_reviews_path
    end

    it 'shows title' do
      expect(page).to have_content(review.title)
    end

    it 'shows body' do
      expect(page).to have_content(review.body)
    end

    it 'shows status' do
      expect(page).to have_content(review.review_status)
    end

    it 'shows score' do
      expect(page).to have_content(review.score)
    end

    it 'shows user email' do
      expect(page).to have_content(review.user.email)
    end

    it 'shows reviewed book' do
      expect(page).to have_content(review.book.title)
    end
  end

  describe '#show' do
    before do
      visit admin_review_path(review)
    end

    it 'shows title' do
      expect(page).to have_content(review.title)
    end

    it 'shows body' do
      expect(page).to have_content(review.body)
    end

    it 'shows score' do
      expect(page).to have_content(review.score)
    end

    it 'shows user email' do
      expect(page).to have_content(review.user.email)
    end

    it 'shows reviewed book' do
      expect(page).to have_content(review.book.title)
    end

    it 'shows status' do
      expect(page).to have_content(review.review_status)
    end
  end
end
