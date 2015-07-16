class PostsController < ApplicationController

  def index
    @users = User.all
    @posts = Post.all.order(id: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.all
    @post_id = Post.all
  end

  def new
    unless current_user
      flash[:alert] = "Please log in to post"
      redirect_to posts_path
    else
       flash[:alert] = "#{current_user.username}: is logged in"
      @post = Post.new
    end
  end

  def create
    @user = current_user
    @post = current_user.posts.create params[:post]
    flash[:alert] = "You made a new post!"
    redirect_to posts_path
    # redirect to "feed"
    #render: "name of the view" (this would re-render.  Can use a string or symbol)
  end
end


  