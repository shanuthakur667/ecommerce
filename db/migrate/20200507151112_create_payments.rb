class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :status, default: 0
      t.integer :payment_type
      t.float :amount, precision: 15, scale: 3, default: 0.0
      t.text :call_response
      t.references :order
      t.references :user
      t.timestamps
    end
  end
end
