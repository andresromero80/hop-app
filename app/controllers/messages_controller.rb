class MessagesController < ApplicationController
  before_action :find_conversation
  before_action :authenticate_user!

  def index
    # @product = Product.find(params[:product_id])
    @messages = @conversation.messages

    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    @message = @conversation.messages.new
  end

  def create
    puts params
    @message = @conversation.messages.new(message_params)
    if @message.save
       # Tell the UserMailer to send a welcome email after save
        # @user = User.find(message_params[:user_id])
        #Message to sender
        sender = User.find(@conversation.sender_id)
        MessageMailer.with(user: sender).message_email.deliver_now
        #Message to recipient
        recipient = User.find(@conversation.recipient_id)
        MessageMailer.with(user: recipient).message_email.deliver_now

        @last_message = @conversation.messages.last
        if @message.save
          respond_to do |format|
            format.html
            format.js
          end
       end
    end
  end

  def new
    @message = @conversation.messages.new
  end

  private

    def message_params
      params.require(:message).permit(:body, :user_id)
    end

    def find_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end
end
