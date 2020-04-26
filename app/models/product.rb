class Product < ApplicationRecord
  include ProductSearchable

  belongs_to :company
  belongs_to :category


end
