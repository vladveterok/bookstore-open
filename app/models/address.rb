class Address < ApplicationRecord
  validates :type, presence: true
  validates :country, presence: true
  validates :first_name, presence: true, length: { in: Constants::NAME_LENGTH },
                         format: { with: Constants::NAME_FORMAT }
  validates :last_name, presence: true, length: { in: Constants::NAME_LENGTH },
                        format: { with: Constants::NAME_FORMAT }
  validates :address, presence: true, format: { with: Constants::ADDRESS_FORMAT }
  validates :city, presence: true, length: { in: Constants::NAME_LENGTH },
                   format: { with: Constants::NAME_FORMAT }
  validates :zip, presence: true, length: { maximum: Constants::ZIP_LENGTH },
                  format: { with: Constants::ZIP_FORMAT }
  validates :phone, presence: true, length: { maximum: Constants::PHONE_LENGTH },
                    format: { with: Constants::PHONE_FORMAT }
  validate :phone_of_selected_country, if: -> { phone.present? }

  belongs_to :user

  private

  def phone_of_selected_country
    errors.add(:phone) if phone.present? && phone.exclude?("+#{ISO3166::Country[country].country_code}")
  end
end
