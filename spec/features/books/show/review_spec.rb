RSpec.describe 'Books show review', type: :feature do
  let(:user) { create(:user) }
  let(:book) { create(:book, :with_images) }

  before do
    sign_in(user)
    visit book_path(book)
  end

  context 'when filling in form' do
    context 'with correct input' do
      it 'shows success message' do
        fill_in(I18n.t('simple_form.labels.defaults.title'), with: FFaker::Lorem.word)
        fill_in(I18n.t('simple_form.labels.defaults.body'), with: FFaker::Lorem.sentence)
        first('#star-score').click
        click_button(I18n.t('show.review.post_btn'))

        expect(page).to have_content(I18n.t('show.review.created'))
      end
    end
  end
end
