class ProfileController < ApplicationController
	def account
	end

	def archives
	end

	def close
	end

	def favourites
	end

	def my_ads
	end

	def loan_requests_pending
		@requests_from_others = LoanAsk.find_by(loaner_id: current_user.id)
		@my_asks = LoanAsk.find_by(receiver_id: current_user.id)
	end

	def saved_search
	end
end
