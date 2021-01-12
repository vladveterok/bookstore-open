RSpec.describe 'Carts show page', type: :feature do
  let(:cart) { create(:cart) }
  let(:book_with_images) { create(:book, :with_images) }
  let(:line_items) { create_list(:line_item, 2, book: book_with_images, cart: cart) }

  before do
    user = create(:user)
    sign_in(user)
    line_items
    user.carts << cart
    visit cart_path
  end

  describe 'cart item deletion', js: true do
    before do
      first('a.close.general-cart-close').click
    end

    it 'deletes cart item from cart' do
      expect(page.all('a.close.general-cart-close').count).to eq line_items.length - 1
    end
  end

  describe 'book quantity change', js: true do
    let(:quantity) { 2 }

    before do
      page.all('a.b-n.input-link.plus').first.click
    end

    it 'increases book quantity by 1' do
      expect(page).to have_field('books-count', with: quantity, wait: 0.5)
    end
  end

  describe 'coupon feature', js: true do
    let(:invalid_coupon_code) { 'invalid' }
    let(:valid_coupon) { create(:coupon) }

    it 'shows invalid coupon notice' do
      fill_in(I18n.t('simple_form.placeholders.defaults.code'), with: invalid_coupon_code)
      click_button(I18n.t('helpers.submit.coupon.submit'))
      expect(page).to have_content(I18n.t('cart.coupon.not_applied'))
    end

    it 'shows valid coupon alert' do
      fill_in(I18n.t('simple_form.placeholders.defaults.code'), with: valid_coupon.code)
      click_button(I18n.t('helpers.submit.coupon.submit'))
      expect(page).to have_content(I18n.t('cart.coupon.applied'))
    end
  end
end
