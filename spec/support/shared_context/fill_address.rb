RSpec.shared_context 'when fill_address_valid' do
  before do
    within(:css, "##{address}") do
      fill_in(I18n.t('simple_form.placeholders.defaults.first_name'), with: address_attributes[:first_name])
      fill_in(I18n.t('simple_form.placeholders.defaults.last_name'), with: address_attributes[:last_name])
      fill_in(I18n.t('simple_form.placeholders.defaults.address'), with: address_attributes[:address])
      fill_in(I18n.t('simple_form.placeholders.defaults.city'), with: address_attributes[:city])
      fill_in(I18n.t('simple_form.placeholders.defaults.zip'), with: address_attributes[:zip])
      select(ISO3166::Country.find_country_by_alpha2(address_attributes[:country])
                             .unofficial_names.first, from: 'address_country')
      fill_in(I18n.t('simple_form.placeholders.defaults.phone'), with: address_attributes[:phone])
      click_button(I18n.t('helpers.submit.address.update'))
    end
  end
end

RSpec.shared_context 'when fill_address_invalid' do
  before do
    within(:css, "##{address}") do
      fill_in(I18n.t('simple_form.placeholders.defaults.first_name'), with: invalid_name)
      fill_in(I18n.t('simple_form.placeholders.defaults.last_name'), with: address_attributes[:last_name])
      fill_in(I18n.t('simple_form.placeholders.defaults.address'), with: address_attributes[:address])
      fill_in(I18n.t('simple_form.placeholders.defaults.city'), with: address_attributes[:city])
      fill_in(I18n.t('simple_form.placeholders.defaults.zip'), with: address_attributes[:zip])
      find('.form-control#address_country').find(:xpath, "option[#{rand(1..ISO3166::Country.all.length)}]")
                                           .select_option
      fill_in(I18n.t('simple_form.placeholders.defaults.phone'), with: address_attributes[:phone])
      click_button(I18n.t('helpers.submit.address.update'))
    end
  end
end

RSpec.shared_context 'when in checkout fill address valid', js: true do
  before do
    within(:css, 'div.col-md-5.mb-40') do
      fill_in(I18n.t('simple_form.placeholders.defaults.first_name'), with: address_attributes[:first_name])
      fill_in(I18n.t('simple_form.placeholders.defaults.last_name'), with: address_attributes[:last_name])
      fill_in(I18n.t('simple_form.placeholders.defaults.address'), with: address_attributes[:address])
      fill_in(I18n.t('simple_form.placeholders.defaults.city'), with: address_attributes[:city])
      fill_in(I18n.t('simple_form.placeholders.defaults.zip'), with: address_attributes[:zip])
      page.select('Ukraine', from: 'cart_billing_address_country')
      fill_in(I18n.t('simple_form.placeholders.defaults.phone'), with: '+380999999999')
    end
  end
end
