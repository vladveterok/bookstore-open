class CreateCartDeliveryMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_delivery_methods do |t|
      t.references :cart, foreign_key: true
      t.references :delivery_method, foreign_key: true

      t.timestamps
    end
  end
end
