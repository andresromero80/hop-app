class Product < ApplicationRecord
  belongs_to :inventory
  has_and_belongs_to_many :categories
  has_many :loans
  has_many_attached :uploads
end
