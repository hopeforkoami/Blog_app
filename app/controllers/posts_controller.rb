class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @current_user = self.current_user
    @post = Post.new
    puts"getting out of the new method"
  end

  def create 
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html{redirect_to user_path(current_user.id)}
        
      else
        render :new
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
