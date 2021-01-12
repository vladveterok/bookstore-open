class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :year_of_publication
      t.integer :quantity
      t.decimal :price, precision: 5, scale: 2, default: 0, null: false
      t.float :height
      t.float :width
      t.float :depth
      t.string :material
      t.json :images, null: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
