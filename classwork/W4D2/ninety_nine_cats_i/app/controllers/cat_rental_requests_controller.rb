class CatRentalRequestsController <ApplicationController
  def create
    @cat_rental_request = CatRentalRequest.new(request_params)

    if @cat_rental_request.save
      redirect_to cats_url
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  def approve
    current_request.approve!
    redirect_to cat_url(current_cat)
  end

  def deny
    current_request.deny!
    redirect_to cat_url(current_cat)
  end

  private

  def current_cat
    current_request.cat
  end

  def current_request
    @cat_rental_request ||=
      CatRentalRequest
        .includes(:cat)
        .find(params[:id])
  end

  def request_params
    params.require(:cat_rental_requests).permit(:start_date, :end_date, :cat_id)
  end
end
