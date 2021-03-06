class LoansController < ApplicationController
	before_action :loan_param, only: ['create']

	def loan_param
		params.require(:loan).permit(:borrower_id, :owner_id, :product_id, :limit_date)
	end 

	def ask
		@permitted = loan_param
		Loan.create(@permitted)

    if Conversation.between(@permitted[:borrower_id], @permitted[:owner_id]).present?
      @conversation = Conversation.between(params[:borrower_id], @permitted[:owner_id]).first
    else
    	conversation_params = {
    		sender_id: @permitted[:borrower_id], 
    		recipient_id: @permitted[:owner_id]
    	}
      @conversation = Conversation.create!(conversation_params)
    end
    
    redirect_to conversation_messages_path(@conversation)
	end

	def ask_cancel

	end

	def ask_confirm
		@loan = Loan.find(params[:loan_id].to_i)
		object_params = { is_accepted: true }
		@loan.update(object_params)
		 #Message to borrower
        borrower = User.find(@loan.borrower_id)
        LoanMailer.with(user: borrower).loan_accept_email.deliver_now
        
  	respond_to do |format|
      format.html
      format.js
    end
	end

	def ask_refuse
		@loan = Loan.find(params[:loan_id].to_i)
		object_params = { is_accepted: false }
		@loan.update(object_params)

  	respond_to do |format|
      format.html
      format.js
    end
	end

	def back_ask
		loan = Loan.find(params[:loan_id].to_i)
		object_params = { back_ask: true }
		loan.update(object_params)
		 #Message to owner
        owner = User.find(loan.owner_id)
        LoanMailer.with(user: owner).loan_return_email.deliver_now

	end

	def back_confirm
		@loan = Loan.find(params[:loan_id].to_i)
		object_params = { back_confirm: true }
		@loan.update(object_params)
		#Message to borrower
        borrower = User.find(@loan.borrower_id)
        LoanMailer.with(user: borrower).loan_return_confirm_email.deliver_now

    respond_to do |format|
      format.html
      format.js
    end
	end

	def back_refuse
		@loan = Loan.find(params[:loan_id].to_i)
		object_params = { back_confirm: false }
		@loan.update(object_params)

  	respond_to do |format|
      format.html
      format.js
    end
	end

	def destroy

	end
end