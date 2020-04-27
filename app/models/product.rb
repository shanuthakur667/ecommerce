class Product < ApplicationRecord
  include ProductSearchable

  belongs_to :company
  belongs_to :category


  def self.search(query)
    self.__elasticsearch__.search(
      {
        query: search_query(query)
      }
    )
  end

  def self.search_query query
    unless query.present?
      {match_all: {}}
    else
      {multi_match: {
        query: query,
        fields: ['name^2', 'category_name', 'category_description', 'company_name^1'],
        fuzziness: "AUTO"
      }}
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
