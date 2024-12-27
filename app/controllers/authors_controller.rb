class AuthorsController < ApplicationController

  def index
    authors = Author.all
    render json: authors, status: :ok
    # show_all_authors
  end

  def create
    author = Author.new(author_params)
    if author.save
      render json: author, status: :created
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  # def update
  #   author = Author.find_by(params[:id])
  #   if author.update(author_params)
  #     render json: author, status: :ok
  #   else
  #     render json: author.errors, status: :unprocessable_content
  #   end
  # end

  def show
    author = Author.find_by(id: params[:id])
    if author
      render json: author, status: :ok
    else
      render json: author.errors, status: :not_found
    end
  end

  def edit
    author = Author.find_by(params[:id])
    if author.update(author_params)
      render json: author, status: :created
    else
      render json: author.errors, status: :unprocessable_content
    end
  end

  def destroy
    author = Author.find_by(id: params[:id])
    if author
      author.destroy
      head :no_content
    else
      render json: { error: "Author not found" }, status: :not_found
    end
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end
end
