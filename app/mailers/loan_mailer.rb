class LoanMailer < ApplicationMailer
  default from: 'halt.overproduce@gmail.com'
 
  def loan_accept_email
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Your request is accepted!')
  end
end
