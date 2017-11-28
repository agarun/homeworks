class ArtworkSharesController < ApplicationController
  def create
    share = ArtworkShare.new(artwork_share_params)
    
    if share.save
      render json: share
    else
      render json: share.errors.full_messages
    end
  end
  
  def destroy
    share = ArtworkShare.find(params[:id])
    
    if share.destroy
      render json: share
    else
      render json: share.errors.full_messages
    end
  end
  
  private 
  
  def artwork_share_params
    params[:artwork_share].permit(:artwork_id, :viewer_id)
  end
end
