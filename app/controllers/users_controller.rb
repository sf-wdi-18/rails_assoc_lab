class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      redirect_to(login_path, flash:{ success: "Registered successfully. Please login." })
    else
      flash.now[:alert] = "There was a problem with your registration"
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
