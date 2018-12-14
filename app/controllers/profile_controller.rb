require 'json'
require 'geocoder'

class ProfileController < ApplicationController
	before_action :if_logged

	attr_accessor :user_verification

	def locate_user
		coordinates = current_user.address.geocode
	end

	def if_logged
		redirect_to '/users/login' unless current_user
	end

	## Methods about THE BORROWER
	def asks_pending
		@objects = Loan.where(borrower_id: current_user.id, is_accepted: nil)
		@view = "asks/asks_pending"
		render "loans", objects: @objects
	end

	def asks_current
		@objects = Loan.where(borrower_id: current_user.id, is_accepted: true)
		@view = "asks/asks_current"
		render "loans", objects: @objects
	end

	def asks_past
		@objects = Loan.where(borrower_id: current_user.id, is_accepted: true, back_confirm: true)
		@view = "asks/asks_past"

		render "loans", objects: @objects
	end
	############################

	## Methods about THE OWNER
	def requests_pending
		@objects = Loan.where(owner_id: current_user.id, is_accepted: nil)
		@view = "requests/requests_pending"
		render "loans", objects: @objects
	end

	
	def requests_current
		@objects = Loan.where(owner_id: current_user.id, is_accepted: true)

		@view = "requests/requests_current"

		render "loans", objects: @objects
	end

	def requests_past
		@objects = Loan.where(owner_id: current_user.id, is_accepted: true, back_confirm: true)
		@view = "requests/requests_past"

		render "loans", objects: @objects
	end
	############################

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