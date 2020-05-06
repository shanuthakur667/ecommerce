class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.integer :status, default: 0
      t.float :total_price, precision: 15, scale: 3, default: 0.0
      t.integer :number_of_item, default: 0
      t.timestamps
    end
  end
end
