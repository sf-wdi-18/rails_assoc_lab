class SessionsController < ApplicationController

  #
  # GET /login
  #
  def new
    # Note that 'render :new' will be executed automatically
  end

  #
  # POST /login
  #
  # See app/views/layout/application.html.erb for Flash implementation
  #
  def create
    if login_params[:email].present? && login_params[:password].present?
      # email and password entered, ok
      if User.find_by(email:login_params[:email])
        # found a user, ok
        auth_user = User.confirm(login_params[:email], login_params[:password])
        if auth_user
          # user authorized, ok
          session[:user_id] = auth_user.id
          # pass either auth_user or auth_user.id to the path helper
          # -> Rails will figure it out
          redirect_to(user_path(auth_user), flash:{ success: "Logged in successfully" })
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

  #
  # GET /logout
  #
  def destroy
    session[:user_id] = nil
    redirect_to('/', flash:{ success: "Logged out successfully" })
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end

end