class LoansController < ApplicationController
	before_action :loan_param, only: ['create']

	def loan_param
		params.require(:loan).permit(:loaner_id, :receiver_id, :product_id, :loan_back_limit)
	end 

	def loan_ask
		@loan = Loan.new

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

	def loan_confirm

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