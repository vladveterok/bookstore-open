class BankCard < ApplicationRecord
  validates :number, presence: true, format: { with: Constants::NUMBER_FORMAT }
  validates :expiration_date, presence: true, format: { with: Constants::DATE_FORMAT }
  validates :cvv, presence: true, format: { with: Constants::NUMBER_FORMAT }
  validates :name, presence: true, format: { with: Constants::NAME_FORMAT }

  belongs_to :cart
end
