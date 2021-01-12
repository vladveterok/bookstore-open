class Review < ApplicationRecord
  enum review_status: { unprocessed: 'unprocessed', approved: 'approved', rejected: 'rejected' }

  validates :title, presence: true, format: { with: Constants::REVIEW_FORMAT },
                    length: { maximum: Constants::REVIEW_TITLE_LENGTH }
  validates :body, presence: true, format: { with: Constants::REVIEW_FORMAT },
                   length: { maximum: Constants::REVIEW_BODY_LENGTH }
  validates :score, numericality: { only_integer: true, less_than_or_equal_to: Constants::REVIEW_SCORE_RANGE.max }

  belongs_to :user
  belongs_to :book

  scope :with_user, -> { includes([:user]) }
  scope :processed, -> { where(review_status: %i[approved rejected]) }
end
