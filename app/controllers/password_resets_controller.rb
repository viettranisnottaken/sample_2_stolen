class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]

  def new

  end
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Pls check ur email"
      redirect_to root_path
    else
      render :new # , alert: "Don't lie to me"
      flash.now[:danger] = "Don't lie to me"
    end
  end

  def edit
    # @user = User.find_by(email: params[:email].downcase)
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_path
      flash[:error] = "Have you activated your account or checked your email?"
    end
  end
  def update
    # @user = User.find_by(email: params[:email].downcase)
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired"
      redirect_to new_password_reset_url
    elsif params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render :edit
    elsif @user.update_attribute(user_params)
      flash[:success] = "Password has been reset"
      # log_in @user
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email].downcase)
  end
end
