class Campaign < ApplicationRecord
  validates :network_criteria, presence: true

  #
  # Return Campaigns matching a peculiar network
  #
  scope :matching, ->(network, user) do
    per_network(network.name)
      .views_less_than(network.views_count)
      .likes_less_than(network.likes_count)
      .subscribers_less_than(network.subscribers_count)
      .age_include(user.age)
      .per_country(user.country)
  end

  scope :per_network,  ->(name) { where(network_criteria: name.to_s) }
  scope :per_country, ->(name) { where(country_criteria: [name.to_s, nil]) }
  scope :views_less_than, ->(count) do
    where(Campaign.arel_table[:views_criteria].lteq(count.to_i))
      .or(Campaign.where(views_criteria: nil))
  end
  scope :likes_less_than, ->(count) do
    where(Campaign.arel_table[:likes_criteria].lteq(count.to_i))
      .or(Campaign.where(likes_criteria: nil))
  end
  scope :subscribers_less_than, ->(count) do
     where(Campaign.arel_table[:subscribers_criteria].lteq(count.to_i))
      .or(Campaign.where(subscribers_criteria: nil))
  end
  scope :age_include, -> (age) do
    where(Campaign.arel_table[:min_age_criteria].lteq(age.to_i))
      .or(Campaign.where(min_age_criteria: nil))
      .where(Campaign.arel_table[:max_age_criteria].gteq(age.to_i))
      .or(Campaign.where(max_age_criteria: nil))
  end
end
