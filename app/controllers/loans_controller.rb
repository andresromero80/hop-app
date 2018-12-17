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
	end

	def back_confirm
		@loan = Loan.find(params[:loan_id].to_i)
		object_params = { back_confirm: true }
		@loan.update(object_params)

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