class LoansController < ApplicationController
	before_action :loan_param, only: ['create']

	def loan_param
		params.require(:loan).permit(:loaner_id, :receiver_id, :product_id, :loan_back_limit)
	end 

	# def confirm_loan_ask
	# 		@loan_ask = LoanAsk.create(product_id: params[:id_product], loaner_id: params[:id_loaner], receiver_id: current_user.id)
	
	# end

	def loan_ask
		@loan_ask = LoanAsk.create(product_id: params[:id_product], loaner_id: params[:id_loaner], receiver_id: current_user.id)

    if Conversation.between(current_user.id, params[:id_loaner]).present?
      @conversation = Conversation.between(current_user.id, params[:id_loaner]).first
    else
    	conversation_params = {
    		sender_id: current_user.id, 
    		recipient_id: params[:id_loaner]
    	}
      @conversation = Conversation.create!(conversation_params)
    end
    
    redirect_to conversation_messages_path(@conversation)
	end

	def confirm
		loan_ask = LoanAsk.find(params[:loan_ask_id].to_i)
		loan_ask.update(loaner_confirm: true)
		loan = Loan.create(loan_ask_id: loan_ask.id)
	end

	def refuse
		loan_ask = LoanAsk.find(params[:loan_ask_id].to_i)
		loan_ask.update(loaner_confirm: false)
	end

	def loan_return

	end

	def loan_return_confirmation
	end

	def create
		@permitted = loan_param
		@loan = Loan.create(@permitted)
	end

	def destroy

	end
end