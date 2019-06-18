class PostsController < ApplicationController
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
    # @posts = Post.all
  end
  def show
    @post = Post.find(params[:id])
  end
  def new #no view yet
    #code
  end
  def update
    #code
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: "abc"
  end
end
