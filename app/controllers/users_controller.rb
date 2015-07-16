 class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = current_user
    @posts = Post.where(user_id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.all

    if User.find_by(params[:user])
      flash[:alert] = "This user exists already"
      redirect_to new_user_path
    elsif
      params[:user][:password] == params[:password_confirmation]
      @user = User.create params[:user]
      flash[:alert] = "#{@user.username} has been signed up"
      redirect_to posts_path
    else
      flash[:alert] = "Your password did not match confirmation"
      redirect_to new_user_path
    end
  end

  def edit
    @user = current_user
  end

  def update  
    @user = current_user
    if @user.update(params[:user])
      redirect_to user_path(@user)
    end
  end

  def destroy
    flash[:alert] = "#{current_user.username} has been deleted"
    @user = User.destroy(session[:user_id])
    session.clear
    redirect_to root_path
  end

end