class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author_id = current_user.id
    @like.post_id = params[:post_id]
    @like.save
    redirect_to user_post_path(user_id: current_user.id, id: params[:post_id])
  end
end
