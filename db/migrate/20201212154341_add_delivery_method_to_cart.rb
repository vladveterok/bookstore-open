class AddDeliveryMethodToCart < ActiveRecord::Migration[6.0]
  def change
    add_reference :carts, :delivery_method, foreign_key: true
  end
end
