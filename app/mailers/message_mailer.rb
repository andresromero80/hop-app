class MessageMailer < ApplicationMailer
  default from: 'halt.overproduce@gmail.com'
 
  def welcome_email
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def message_email
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'You a new message from HOP')
  end
end
