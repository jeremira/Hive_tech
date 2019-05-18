class AddCountryAgeToUserTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :country, :string
    add_column :users, :dob, :datetime
  end
end
