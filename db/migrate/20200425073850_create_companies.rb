class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :code
      t.string :name
      t.string :phone
      t.text :description
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
