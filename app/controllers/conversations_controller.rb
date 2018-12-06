class ConversationsController < ApplicationController
	before_action :authenticate_user!

  def index
    # @product = Product.find(params[:product_id])
    @products = Product.all
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    @product = Product.find(params[:product_id])
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(sender_id: params[:sender_id] ,recipient_id: params[:recipient_id], product: @product)
      #Creation d'objet LoanAsk
      @loan_ask = LoanAsk.create(receiver: User.find(params[:sender_id]), loaner: User.find(params[:recipient_id]), product: @product)
    end
    redirect_to product_conversation_messages_path(@conversation, @product.id)
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end
