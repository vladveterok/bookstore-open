FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    provider { 'facebook' }
    password { "#{FFaker::Internet.password(9, 16).delete('_')}1Ab" }
    uid { rand(9**16) }

    trait :with_cart do
      transient do
        aasm_state { :address }
      end
      after(:build) do |user, evaluator|
        user.carts = [FactoryBot.create(:cart, aasm_state: evaluator.aasm_state)]
      end
    end
  end
end
