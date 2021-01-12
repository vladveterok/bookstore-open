module Constants
  DEFAULT_DISCOUNT = 0
  DEFAULT_COST = 0

  LINE_ITEMS_QUANTITY = 0

  DISCOUNT_MIN_MAX = [0, 100].freeze

  NAME_LENGTH = (1..50).freeze
  NAME_FORMAT = /\A[A-Za-z\s]+\z/.freeze

  NUMBER_FORMAT = /\A\d+\z/.freeze
  DATE_FORMAT = %r/\A(0[1-9]|10|11|12)\/[0-9]{2}\z/.freeze

  PASSWORD_FORMAT = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/.freeze
  ADDRESS_FORMAT = /\A[a-zA-Z0-9\s,\-]+\z/.freeze

  PHONE_LENGTH = 16
  PHONE_FORMAT = /\A\+[0-9]{1,3}\s?[0-9]{2}\s?[0-9]{3}\s?[0-9]{4}\z/.freeze

  ZIP_LENGTH = 10
  ZIP_FORMAT = /\A[0-9\-]+\z/.freeze

  REVIEW_TITLE_LENGTH = 80
  REVIEW_BODY_LENGTH = 500
  REVIEW_SCORE_RANGE = (0..5).freeze
  REVIEW_FORMAT = %r/\A[\w!#$%&'*+-\/=?^`{|}~\s]+\z/.freeze

  BOOKS_QUANTITY = 1
end
