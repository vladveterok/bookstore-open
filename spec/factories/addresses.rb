FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.html_safe_last_name }
    address { FFaker::AddressUS.street_address.gsub(/[^a-zA-Z0-9]/, '') }
    city { FFaker::AddressUS.city.gsub(/[^a-zA-Z]/, '') }
    zip { FFaker::AddressUS.zip_code }
    country { ISO3166::Country.all.sample.alpha2 }
    phone { "+#{ISO3166::Country[country].country_code}#{Faker::Number.number(digits: 9)}" }
    user

    trait :billing do
      type { 'BillingAddress' }
    end

    trait :shipping do
      type { 'ShippingAddress' }
    end
  end
end
