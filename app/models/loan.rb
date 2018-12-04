class Loan < ApplicationRecord
	belongs_to :product
	belongs_to :loaner, class_name: 'User', foreign_key: 'loaner_id'
	belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
end