class UserMailer < ApplicationMailer
  default from: "hello@wheelhouse.cl"

  def welcome
    @user = params[:user]
    mail(to: @user.email_address, subject: "Welcome to Wheelhouse")
  end
end