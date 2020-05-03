class Company < ApplicationRecord
  # has_many :catrgories
  has_many :products#, through: :catrgories
  after_update :es_update

  private

  def es_update
    Product.includes(:company).where(company_id: self.id).each do |product|
      product.update_company({company_name: product.company_name, company: {id: product.id, name: product.name, code: product.code}}, {id: product.id})
    end
  end
end
