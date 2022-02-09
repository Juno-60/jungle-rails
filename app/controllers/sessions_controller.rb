class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      #save user id inside browser cookie. keeps user logged in while navigating throughout site
      session[:user_id] = user.id
      redirect_to '/'
    else
      # ...otherwise send them back to login form
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
