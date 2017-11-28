class ArtworksController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: user.artworks + user.shared_artworks

    # or:
    # render json: Artwork.artworks_for_user_id(params[:user_id])
  end

  def create
    artwork = Artwork.new(artwork_params)

    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: 422
    end
  end

  def show
    artwork = Artwork.find(params[:id])
    render json: artwork
  end

  def update
    artwork = Artwork.find(params[:id])

    if artwork.update(artwork_params)
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: 422
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])

    if artwork.destroy
      render json: "DESTROYED"
    else
      render json: artwork.errors.full_messages, status: 422
    end
  end

  private

  def artwork_params
    params[:artwork].permit(:title, :image_url, :artist_id)
  end
end
