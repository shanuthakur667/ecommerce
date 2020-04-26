class Company < ApplicationRecord
  # has_many :catrgories
  has_many :products#, through: :catrgories
end
