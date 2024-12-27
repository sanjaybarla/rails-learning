class AddDobAndGenderToAuthors < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :dob, :date
    add_column :authors, :gender, :integer
  end
end
