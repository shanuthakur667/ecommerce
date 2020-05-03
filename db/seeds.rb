# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Company.create(code: "nik01", name: "Nike", phone: "9716471488", description: "Description. NIKE, Inc., together with its subsidiaries, designs, develops, markets, and sells athletic footwear, apparel, equipment, and accessories worldwide. The company offers NIKE brand products in six categories, including running, NIKE basketball, the Jordan brand, football, training, and sportswear.")

Company.create(code: "Pum01", name: "Puma", phone: "9116471488", description: "Puma SE, branded as Puma, is a German multinational corporation that designs and manufactures athletic and casual footwear, apparel and accessories, which is headquartered in Herzogenaurach, Bavaria, Germany. Puma is the third largest sportswear manufacturer in the world.")

['Clothes', 'Electronics', 'Food', 'Grooming', 'Baby care'].each do |category|
  Category.create(name: category, description: "A product description is the marketing copy that explains what a product is and why it's worth purchasing.")
end

company_ids = Company.pluck(:id)

cloth_datas = [{company_id: company_ids.sample, name: "hard style", quantity: 10, unit_price: 1000, description: "fine lather shoes", code:  'clo1', status: true}, {company_id: company_ids.sample, name: "Sport style", quantity: 15, unit_price: 1200, description: "fine sportwear shoes", code:  'clo32', status: true}, {company_id: company_ids.sample, name: "high bottom", quantity: 7, unit_price: 800, description: "stylish jeans", code:  'clo3', status: true}]
cloth_datas.each do |cloth_data|
  ca = Category.find_by(name: "Clothes")
  ca.products.create(cloth_data)
end

electronics_data = [{company_id: company_ids.sample, name: "fast corner fan", quantity: 12, unit_price: 1500, description: "fine fast corner fan", code:  'ele1', status: true}, {company_id: company_ids.sample, name: "AC for summer", quantity: 5, unit_price: 20000, description: "high cooling AC", code:  'ele2', status: true}, {company_id: company_ids.sample, name: "Water purifier", quantity: 8, unit_price: 900, description: "Water purifier for fresh and clean water", code:  'ele3', status: true}]
electronics_data.each do |electronic_data|
  ca = Category.find_by(name: "Electronics")
  ca.products.create(electronic_data)
end

foods_data = [{company_id: company_ids.sample, name: "High quality ricr", quantity: 10, unit_price: 50, description: "pure rice", code:  'foo1', status: true}, {company_id: company_ids.sample, name: "maggie", quantity: 5, unit_price: 20000, description: "noodels for kids", code:  'foo2', status: true}, {company_id: company_ids.sample, name: "pepsi", quantity: 8, unit_price: 900, description: "cold drink and drinking", code:  'foo3', status: true}]
foods_data.each do |food_data|
  ca = Category.find_by(name: "Food")
  ca.products.create(food_data)
end

groomings_data = [{company_id: company_ids.sample, name: "eye liener for girls", quantity: 10, unit_price: 200, description: "eye care", code:  'groo1', status: true}, {company_id: company_ids.sample, name: "facieal cream", quantity: 20, unit_price: 200, description: "skin care", code:  'groo2', status: true}]

groomings_data.each do |grooming_data|
  ca = Category.find_by(name: "Grooming")
  ca.products.create(grooming_data)
end
