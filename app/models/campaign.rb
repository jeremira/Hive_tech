class Campaign < ApplicationRecord
  validates :network_criteria, presence: true

  #
  # Return Campaigns matching a peculiar network
  #
  scope :matching, ->(network) do
    network_name(network.name).views_less_than(network.views_count)
  end

  scope :network_name,  ->(name) { where(network_criteria: name.to_s) }
  scope :views_less_than, ->(count) { where(Campaign.arel_table[:views_criteria].lteq(count.to_i))}

  # Campaign.per_network(network)
  #
  #User.arel_table[:id].gt(200)
  # return Campaign qui match User.networks
  #
  # Campaign.where(network_criteria: network.name)
  #         .where(views_criteria: > network.views_count)
  #
  # query = Campaign.all
  #
  # User.networks.each do |network|
  #   Campaign.per_network(network)
  # end

end
