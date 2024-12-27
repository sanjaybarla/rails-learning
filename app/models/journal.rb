class Journal < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :books

  def reference_books
    books
  end

  def auth
    author
  end
end
