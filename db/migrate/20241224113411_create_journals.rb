class CreateJournals < ActiveRecord::Migration[8.0]
  def change
    create_table :journals do |t|
      t.string :title
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end