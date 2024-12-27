class BooksController < ApplicationController

  def index
    books = Book.all
    render json: books, status: :ok
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book
      book.destroy
      head :no_content
    else
      render json: { error: "Book not found" }, status: :not_found
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author_id, journal_ids: [])
  end
end
