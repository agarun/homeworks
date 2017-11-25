class BooksController < ApplicationController
  def index
    # your code here
  end

  def new
    # your code here
  end

  def create
    # your code here
  end

  def destroy
    # your code here
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end
