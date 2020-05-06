class Product < ApplicationRecord
  include ProductSearchable

  belongs_to :company
  belongs_to :category
  has_many :order_products
  has_many :orders, through: :order_products

  class << self
    def find_products(query, req_type = nil)
      self.__elasticsearch__.search(
        {
          query: (req_type == "listing" ? list_query(query) : find_query(query))
        }
      )
    end

    def list_query query
      unless query.present?
        {match_all: {}}
      else
        {
          multi_match: {
            query: query,
            fields: ['name^2', 'category_name', 'category_description', 'company_name^1'],
            fuzziness: "AUTO"
          }
        }
      end
    end

    def find_query query
      {
        match: {
          id: query
        }
      }
    end
  end

  def company_name
    company.name
  end

  def category_name
    category.name
  end

  def category_description
    category.description
  end
end
