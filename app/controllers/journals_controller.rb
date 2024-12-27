class JournalsController < ApplicationController

  def index
    journals = Journal.all
    render json: journals, status: :ok
  end

  def create
    journal = Journal.new(journal_params)
    if journal.save
      render json: journal, status: :created
    else
      render json: journal.errors, status: :unprocessable_content
    end
  end

  def show
    journal = Journal.find_by(id: params[:id])
    if journal
      render json: journal, status: :ok
    else
      render json: journal.errors, status: :not_found
    end
  end

  def destroy
    journal = Journal.find_by(id: params[:id])
    if journal
      journal.destroy
      head :no_content
    else
      render json: { error: "Journal not found" }, status: :not_found
    end
  end

  private

  def journal_params
    params.require(:journal).permit(:title, :author_id, book_ids: [])
  end
end
