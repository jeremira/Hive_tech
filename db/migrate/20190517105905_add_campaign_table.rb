class AddCampaignTable < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string     :network_criteria
      t.integer    :views_criteria
      t.integer    :likes_criteria
      t.integer    :subscribers_criteria
      t.integer    :min_age_criteria
      t.integer    :max_age_criteria
      t.string     :country_criteria

      t.timestamps
    end
  end
end
