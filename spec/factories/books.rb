FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    price { rand(5.0..35.0).round(2) }
    year_of_publication { FFaker::Time.date.year }
    height { rand(5.0..15.0).ceil(2) }
    width { rand(5.0..15.0).ceil(2) }
    depth { rand(5.0..15.0).ceil(2) }
    category

    after(:build) do |book|
      book.authors = [build(:author)]
    end

    trait :with_images do
      images { Array.new(4) { File.open('spec/support/fixtures/images/test_image.jpg') } }
    end

    trait :with_line_items_delivered do
      line_items { [create(:line_item, :with_cart_delivered), create(:line_item, :with_cart_delivered)] }
    end
  end
end
