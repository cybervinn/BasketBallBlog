class SessionsController < ApplicationController

  def destroy
    # logs out user
    if current_user
      flash[:alert] = "#{current_user.username}: has logged off"
      session[:user_id] = nil
      redirect_to root_path     
    else
      # user is not logged in and sent to login page
      flash[:alert] = "Please login"
      redirect_to root_path  
    end

  end

  def new
    #redirect to login if user is not logged in
    unless current_user
      redirect_to root_path    
    else
      #user is currently logged in and sent Post page
      flash[:alert] = "User #{current_user.username}: already logged in"
      redirect_to posts_path
    end
  end

  def create
    #Create a new user
    username = params[:username]
    password = params[:password]
  
    @user = User.where(username: username).first

    #check if user exists in data AND if passwords match; if so access is given
    if @user && @user.password == password
      session[:user_id] = @user.id
      flash[:alert] = "Welcome #{current_user.username}"
      redirect_to users_path
    else 
      flash[:alert] = "Invalid Username/Password"
      redirect_to root_path
    end
  end
end 