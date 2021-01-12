class Author < ApplicationRecord
  validates :first_name, presence: true, length: { in: Constants::NAME_LENGTH },
                         format: { with: Constants::NAME_FORMAT }
  validates :last_name, length: { in: Constants::NAME_LENGTH },
                        format: { with: Constants::NAME_FORMAT }

  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books
end
