class User < ApplicationRecord
  attribute :cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  validates :email, presence: true
  validates :password, format: { with: Constants::PASSWORD_FORMAT }, if: :password_required?

  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
  has_many :carts, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
