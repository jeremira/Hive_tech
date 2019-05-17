class CreateNetworks < ActiveRecord::Migration[5.0]
  def change
    create_table :networks do |t|
      t.references :user
      t.string :name
      t.string :type
      t.integer :views_count
      t.integer :subscribers_count
      t.integer :likes_count

      t.timestamps
    end
  end
end
