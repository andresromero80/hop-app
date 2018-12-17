class LoanMailer < ApplicationMailer
  default from: 'halt.overproduce@gmail.com'
 
  def loan_accept_email
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Your request is accepted!')
  end

  def loan_return_email
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'The borrower wants to return material')
  end 

  def loan_return_confirm_email
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'The owner confirmed the return')
  end    
end



