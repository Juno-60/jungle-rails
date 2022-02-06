class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists and password is correct, do this:
    if user && user.authenticate(params[:password])
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
