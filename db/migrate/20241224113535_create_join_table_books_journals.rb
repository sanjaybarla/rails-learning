class CreateJoinTableBooksJournals < ActiveRecord::Migration[7.1]
  def change
    create_join_table :books, :journals do |t|
      # t.index [:book_id, :journal_id]
      # t.index [:journal_id, :book_id]
    end
  end
end
