class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    binding.pry
    @user = User.create(user_params)
  end

  def show
    @user = User.find session[:user_id]
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
