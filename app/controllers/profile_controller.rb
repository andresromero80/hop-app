class ProfileController < ApplicationController
	def account
	end

	def archives
		@loans = LoanAsk.find_by(loaner_id: current_user.id)
		@archived_loans = []

		if !@loans.nil?
			ids = @loans.pluck(:id)
			@archived_loans = LoanBack.where(loan_ask_id: ids)
		end
	end

	def close
	end

	def favourites
	end

	def my_ads
	end

	def my_loan_request
		@my_asks = []
		@my_asks = LoanAsk.where(receiver_id: current_user.id)
		# @my_asks << LoanAsk.find_by(receiver_id: current_user.id)
	end

	def loan_requests_pending
		@requests_from_others = []
		@requests_from_others << LoanAsk.find_by(loaner_id: current_user.id, loaner_confirm: nil)
	end

	def saved_search
	end
end