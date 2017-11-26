class BooksController < ApplicationController
  def index
    @books = Book.all
    render :index
  end

  def new
    render :new
  end

  def create
    Book.create(book_params)

    index
  end

  def destroy
    book = Book.find(params["id"])
    book.destroy

    index
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
