class CommentsController < ApplicationController

 def create
  unless current_user
    flash[:alert] = "Please log in to post"
    redirect_to :back
  else
  @comment = current_user.comments.create params[:comment]
   flash[:alert] = "You added a comment!"
   redirect_to post_path(@comment.post)
  end
 end
end
