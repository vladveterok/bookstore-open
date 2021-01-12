class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.integer :discount, null: false
      t.string :coupon_status, default: 'unused', null: false

      t.timestamps
    end
  end
end
