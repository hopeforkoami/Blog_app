class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]

    respond_to do |format|
      if @comment.save

        format.html { redirect_to user_post_path(params[:user_id], params[:post_id]) }
      else
        render :new
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
