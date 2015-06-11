class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    #pass in array that user_params returns as arguments using a splat
    binding.pry
    user = User.confirm(params[:email], params[:password])
    if user
      #this creates the session, logging in the user
      session[:user_id] = user.id
      #redirect to the show page
      redirect_to user_path(user.id)
    else
      #there was an error logging the user in
      redirect_to login_path
    end
  end

  def destroy
    #TODO: logout the current user
  end

end
