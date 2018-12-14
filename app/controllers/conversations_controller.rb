class ConversationsController < ApplicationController
	before_action :authenticate_user!

  def index
    @products = Product.all
    @users = User.all

    sql = "SELECT DISTINCT * from conversations AS c WHERE c.sender_id=#{current_user.id} OR c.recipient_id=#{current_user.id};"
    @conversations = []
    
    ActiveRecord::Base.connection.execute(sql).each do |row|
      @conversations << Conversation.new(row)
    end
  end

  def create
    @product = Product.find(params[:product_id])
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(sender_id: params[:sender_id] ,recipient_id: params[:recipient_id], product: @product)
    end
    redirect_to product_conversation_messages_path(@conversation, @product.id)
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end
