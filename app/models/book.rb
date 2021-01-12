class Book < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :authors, presence: true

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent: :destroy
  has_many :line_items, dependent: :destroy
  belongs_to :category

  mount_uploaders :images, BookImageUploader

  scope :with_authors, -> { includes([:authors]) }
  scope :filtered, FilteredBooksQuery
  scope :sorted, SortedBooksQuery
  scope :latest, LatestBooksQuery
  scope :best_sellers, BestSellersQuery
end
