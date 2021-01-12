require 'ffaker'

CATEGORIES = [
  'Mobile Development',
  'Photo',
  'Web Design'
].freeze

authors = []
categories = []

10.times do
  authors << Author.create!(first_name: FFaker::Name.first_name,
                            last_name: FFaker::Name.html_safe_last_name,
                            description: FFaker::Book.description)
end

CATEGORIES.each do |category|
  categories << Category.create!(name: category)
end

60.times do
  Book.create(title: FFaker::Book.title,
              description: FFaker::Book.description(rand(1..7)),
              price: rand(5.0..35.0).round(2),
              authors: [authors[rand(0..authors.length - 1)], authors[rand(0..authors.length - 1)]],
              category: categories[rand(0..categories.length - 1)],
              year_of_publication: FFaker::Time.date.year,
              height: rand(5.0..15.0).ceil(2),
              width: rand(5.0..15.0).ceil(2),
              depth: rand(5.0..15.0).ceil(2),
              material: "#{FFaker::Food.meat}, #{FFaker::Food.meat}",
              images: Array.new(rand(1..3)) { Pathname.new(Rails.root.join("db/seeds/images/#{Dir.children('db/seeds/images/').sample}")).open } )
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

2.times do
  DeliveryMethod.create(name: FFaker::Company.name, price: FFaker.numerify('#.##'),
                        days_min: FFaker::Random.rand(1..3), days_max: FFaker::Random.rand(4..6))
end
