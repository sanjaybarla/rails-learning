class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :journals
  has_many :comments, as: :commentable

end
