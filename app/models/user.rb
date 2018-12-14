class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable #added to generate email confirmations after creating account

  belongs_to :address
  accepts_nested_attributes_for :address
  
	has_one_attached :header_image
  has_many :trades
  has_many :loans, :class_name => 'Loans', :foreign_key => 'loaner_id'
  has_many :receives, :class_name => 'Loans', :foreign_key => 'receiver_id'
  has_many :reviews, dependent: :destroy, inverse_of: :reviewer, :class_name => 'Review'
  has_many :notes, dependent: :destroy, inverse_of: :reviewed_user, :class_name => 'Review'

  private
    attr_accessor :verification_code
  public
    def get_verification_code
      @verification_code
    end

    def set_verification_code(code)
      @verification_code = code
    end
end
