FactoryBot.define do
  factory :line_item do
    book
    quantity { 1 }

    trait :with_cart_delivered do
      cart { create(:cart, aasm_state: :delivered) }
    end
  end
end
