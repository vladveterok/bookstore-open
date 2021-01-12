FactoryBot.define do
  factory :delivery_method do
    name { FFaker::Company.name }
    price {  FFaker.numerify('#.##') }
    days_min { FFaker::Random.rand(1..3) }
    days_max { FFaker::Random.rand(4..6) }
  end
end
