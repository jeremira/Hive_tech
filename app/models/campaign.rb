class Campaign < ApplicationRecord
  validates :network_criteria, presence: true
end
