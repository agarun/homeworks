class CommentsController < ApplicationController
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      
      # shows the comments for a user
      render json: user.comments
    elsif params[:artwork_id]
      artwork = Artwork.find(params[:artwork_id])
      
      # shows the comments for an artwork
      render json: artwork.comments
    else
      render "you need to specify a user_id or a artwork_id"
    end
  end
  
  def create
    comment = Comment.new(comment_params)
    
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages
    end
  end
  
  def destroy
    comment = ArtworkShare.find(params[:id])
    
    if comment.destroy
      render json: comment
    else
      render json: comment.errors.full_messages
    end
  end
  
  private 
  
  def comment_params
    params.require(:comment).permit(:body, :artwork_id, :user_id)
  end
end
