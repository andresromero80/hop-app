class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :address
  accepts_nested_attributes_for :address
  
	has_one_attached :header_image
  has_many :trades
  has_many :loans, :class_name => 'Loans', :foreign_key => 'loaner_id'
  has_many :receives, :class_name => 'Loans', :foreign_key => 'receiver_id'
end
