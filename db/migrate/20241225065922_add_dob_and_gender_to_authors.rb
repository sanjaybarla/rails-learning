class AddDobAndGenderToAuthors < ActiveRecord::Migration[8.0]
  def change
    add_column :authors, :dob, :date
    add_column :authors, :gender, :integer
  end
end
