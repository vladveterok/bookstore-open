FactoryBot.define do
  factory :review do
    title { FFaker::Lorem.word }
    body { FFaker::Lorem.sentence }
    score { FFaker::Random.rand(0..5) }
    book
    user

    trait :approved do
      review_status { :approved }
    end

    trait :reject do
      review_status { :reject }
    end
  end
end
