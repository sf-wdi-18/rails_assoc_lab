class SessionsController < ApplicationController

  def new
    # Note that 'render :new' will be executed automatically
  end

  def create
    if login_params[:email].present? && login_params[:password].present?
      # email and password entered, ok
      if User.find_by(email:login_params[:email])
        # found a user, ok
        auth_user = User.confirm(login_params[:email], login_params[:password])
        if auth_user
          # user authorized, ok
          session[:user_id] = auth_user.id
          redirect_to(user_path(auth_user.id), flash:{ success: "Logged in successfully" })
        else
          # bad password
          flash.now[:alert] = "Invalid password"
          # display the login page again
          render :new
        end
      else
        # user not found
        flash[:alert] = "User not found"
        redirect_to(signup_path)
      end
    else
      # incomplete login fields
      flash.now[:alert] = "Please enter your email and password"
      render :new
    end
  end

  def destroy
    #TODO: logout the current user
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end

end