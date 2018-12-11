require 'json'

class ProfileController < ApplicationController
	before_action :if_logged

	attr_accessor :user_verification

	def account
	end

	def if_logged
		redirect_to '/users/login' unless current_user
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
	end

	def loan_requests_pending
		@requests_from_others = []
		@requests_from_others << LoanAsk.find_by(loaner_id: current_user.id, loaner_confirm: nil)
	end

	def saved_search
	end

	def ask_profile_verification
		request_id = ''
		@user_verification = UserVerification.new(current_user)
		@response = @user_verification.send_verification_code
		@request_id = @response.request_id
	end

	def verify_profile
		@user_verification = UserVerification.new(current_user)
		permited = params.permit(:authenticity_token, :verification_code, :request_id)
		@response = @user_verification.verify(permited[:verification_code], permited[:request_id])
	end

	def cancel_profile_verification(request_id)
		@user_verification = UserVerification.new(current_user)
		permited = params.permit(:request_id)
		@user_verification.cancel(permited[:request_id])
	end
end