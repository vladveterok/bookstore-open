class CreateBankCards < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_cards do |t|
      t.string :number, null: false
      t.string :expiration_date, null: false
      t.string :cvv, null: false
      t.string :name, null: false
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
