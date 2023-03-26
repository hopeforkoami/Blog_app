class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

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

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), notice: 'Comment was successfully destroyed.'
    else
      flash.new[:alert] = @comment.errors.full_messages.first if @comment.errors.any?
      render :show, status: 400
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
