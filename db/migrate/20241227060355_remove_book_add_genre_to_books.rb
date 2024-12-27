class RemoveBookAddGenreToBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :Book, :string
    add_column :books, :genre, :string
  end
end
