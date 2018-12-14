class Loan < ApplicationRecord
	has_one :product
	has_one :owner, class_name: 'User', foreign_key: 'owner_id', inverse_of: :owns
	has_one :borrower, class_name: 'User', foreign_key: 'borrower_id', inverse_of: :borrows
end