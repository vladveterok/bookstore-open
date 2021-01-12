class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.references :coupon, foreign_key: true
      t.string :aasm_state
      t.timestamp :completed_at
      t.decimal :ordered_subtotal, precision: 5, scale: 2
      t.decimal :ordered_discount, precision: 5, scale: 2
      t.decimal :ordered_total, precision: 5, scale: 2

      t.timestamps
    end
  end
end
