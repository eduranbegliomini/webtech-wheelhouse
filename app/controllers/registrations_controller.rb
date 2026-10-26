class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      UserMailer.with(user: @user).welcome.deliver_later
      start_new_session_for @user
      redirect_to root_path, notice: "Welcome to Wheelhouse!"
    else
      @user.password = nil
      @user.password_confirmation = nil
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [:email_address, :password, :password_confirmation])
  end
end