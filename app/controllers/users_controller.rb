class UsersController < ApplicationController

  def new
    @user = User.new
  end

  #
  # GET /user/:id
  #
  def show
    # use find_by if you're not certain that the id will not be nil
    # User.find(nil) will crash the app
    @user = User.find_by(id:session[:user_id]) || User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      # log the user in
      session[:user_id] = user.id
      redirect_to(user_path(user), flash:{ registered: "Welcome, #{user.email}" })
    else
      flash.now[:alert] = "There was a problem with your registration"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
