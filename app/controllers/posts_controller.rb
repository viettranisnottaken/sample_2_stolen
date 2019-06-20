class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
    # @posts = Post.all
  end
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])

  end
  def update
    # @post = Post.find(params[:id])
    # if @post.update_attributes(post_params)
    #   flash[:success] = "Profile Updated"
    #   redirect_to posts_path
    # else
    #   render "edit"
    # end
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def new #no view yet
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "New post added!"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def destroy
    if current_user.admin?
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_url, notice: "abc"
    else
      render "index", notice: "Don't get touchy"
    end
  end
end

private

def set_post
  @post = Post.find(params[:id])
end

def post_params
  params.require(:post).permit(:title, :content)
end
