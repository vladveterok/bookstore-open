class LineItem < ApplicationRecord
  validates :quantity, numericality: { greater_than: Constants::LINE_ITEMS_QUANTITY }

  belongs_to :book
  belongs_to :cart

  scope :with_book, -> { includes([:book]) }
end
