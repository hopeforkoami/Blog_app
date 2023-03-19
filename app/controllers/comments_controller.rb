class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
  end
end