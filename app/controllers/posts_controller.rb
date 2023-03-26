class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @current_user = current_user
    @post = Post.new
    puts 'getting out of the new method'
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_path(current_user.id) }

      else
        render :new
      end
    end
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to user_posts_path(current_user.id), notice: 'Post was successfully destroyed.'
    else
      flash.new[:alert] = @post.errors.full_messages.first if @post.errors.any?
      render :show, status: 400
    end
  end
  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
