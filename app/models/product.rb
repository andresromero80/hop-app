class Product < ApplicationRecord
  belongs_to :inventory
  has_one :brand
  has_and_belongs_to_many :categories
  has_many :loans
  has_many_attached :uploads

  accepts_nested_attributes_for :brand

  paginates_per 10
end