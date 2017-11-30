class CatRentalRequestsController <ApplicationController
  
  def create 
    @cat_rental_request = CatRentalRequest.new(request_params)
    @cat_rental_request.approve!
    
    if @cat_rental_request.save
      redirect_to cats_url
    else
      render @cat_rental_request.errors.full_messages
    end
  end 
  
  def request_params 
    params.require(:cat_rental_requests).permit(:start_date, :end_date, :cat_id)
  end
end 

