class Product < ApplicationRecord
  belongs_to :inventory
  has_many :categories
  has_many :loans
end
