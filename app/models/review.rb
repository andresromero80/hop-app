class Review < ApplicationRecord
	belongs_to :reviewer, :class_name => 'User', inverse_of: :reviews
	belongs_to :reviewed_user, :class_name => 'User', inverse_of: :notes
end