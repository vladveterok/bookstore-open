class CreateDeliveryMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_methods do |t|
      t.string :name, null: false
      t.decimal :price, null: false, scale: 2, precision: 10
      t.integer :days_min, null: false
      t.integer :days_max, null: false

      t.timestamps
    end
  end
end
