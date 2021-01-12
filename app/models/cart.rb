class Cart < ApplicationRecord
  include AASM

  belongs_to :user, optional: true
  belongs_to :coupon, optional: true
  belongs_to :delivery_method, optional: true
  has_many :line_items, dependent: :destroy
  has_one :bank_card, dependent: :destroy

  aasm do
    state :address, initial: true
    state :shipment, :payment, :confirmation, :completion,
          :queue, :delivery, :delivered, :canceled

    event(:address) { transitions from: :confirmation, to: :address }
    event(:ship) { transitions from: %i[address confirmation], to: :shipment }
    event(:pay) { transitions from: %i[shipment confirmation], to: :payment }
    event(:confirm) { transitions from: :payment, to: :confirmation }
    event(:complete) { transitions from: :confirmation, to: :completion }
    event(:queue) { transitions from: :completion, to: :queue }
    event(:deliver) { transitions from: :queue, to: :delivery }
    event :complete_delivery do
      after { update(completed_at: Time.zone.now) }
      transitions from: :delivery, to: :delivered
    end
    event(:cancel) { transitions to: :canceled }
  end

  scope :in_progress, -> { where(aasm_state: %i[address shipment payment confirmation completion queue delivery]) }
  scope :open, -> { where(aasm_state: %i[address shipment payment confirmation completion]) }
  scope :sold, -> { where(aasm_state: %i[queue delivery delivered]) }

  scope :with_items, -> { includes([:line_items]) }
  scope :with_user, -> { includes([:user]) }
  scope :with_coupon, -> { includes([:coupon]) }
  scope :with_delivery, -> { includes([:delivery_method]) }

  scope :filtered, FilteredOrdersQuery
end
