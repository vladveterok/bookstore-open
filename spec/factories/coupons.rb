FactoryBot.define do
  factory :coupon do
    code { Faker::Verb.base }
    discount { Faker::Number.within(range: 1..100) }
    coupon_status { :unused }
  end
end
