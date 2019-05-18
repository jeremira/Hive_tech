class Network < ApplicationRecord
  belongs_to :user

  validates :views_count, absence: true, if: proc { |network| network.name == 'instagram' }
end
