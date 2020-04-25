class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.integer :quantity, default: 0
      t.float :unit_price, precision: 15, scale: 3, default: 0.0
      t.text :description
      t.references :company
      t.references :category
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
