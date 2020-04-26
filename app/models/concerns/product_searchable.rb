# require 'elasticsearch/model'
module ProductSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    env = Rails.env

    index_name "ecomm_product_#{env}"

    mapping do
      indexes :id, type:'integer'
      indexes :code, type: 'keyword'
      indexes :name, type: 'text'
      indexes :quantity, type: 'integer', index: 'false'
      indexes :unit_price, type: 'float'
      indexes :description, type: 'text'
      indexes :status, type: 'boolean', index: 'false'
      indexes :company, type: 'object' do
        indexes :id, type: "integer"
        indexes :name, type: "text"
        indexes :code, type: "keyword"
      end
      indexes :category, type: 'object' do
        indexes :id, type: "integer"
        indexes :name, type: "text"
        indexes :description, type: "text"
      end
    end

    def as_indexed_json(options={})
      only_names = [:id, :code, :name,:quantity,:unit_price,:description,:status]
      hash = self.as_json(only: only_names,
        include: {
          company: {only: [:id, :name, :code]},
          category: {only: [:id, :name, :description]}
        })
    end
  end
end
