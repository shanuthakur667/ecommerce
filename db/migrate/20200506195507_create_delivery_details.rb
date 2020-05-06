class CreateDeliveryDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_details do |t|
      t.string :pin_code
      t.string :phone
      t.string :email
      t.string :name
      t.text :full_address
      t.string :city_name
      t.references :order
      t.timestamps
    end
  end
end
