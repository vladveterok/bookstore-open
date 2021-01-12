FactoryBot.define do
  factory :bank_card do
    number { FFaker::Bank.card_number.gsub(/[^0-9]/, '') }
    name { FFaker::Name.html_safe_last_name }
    expiration_date { FFaker::Bank.card_expiry_date }
    cvv { FFaker::Random.rand(100..900) }
    cart
  end
end
