class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :require_author, only: [:update, :destroy]
  before_action :require_at_least_one_sub, only: [:create, :update]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to post_url(@post)
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments.includes(:author)
  end
  
  def require_author
    @post = Post.find(params[:id])
    redirect_to post_url(@post) unless current_user == @post.author
  end
  
  def require_at_least_one_sub
    unless params[:post][:sub_ids]
      flash.now[:errors] = ["choose at least 1 sub"]
      
      @post = Post.new
      params["action"] == "create" ? (render :new) : (render :edit)
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
