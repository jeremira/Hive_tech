class User < ApplicationRecord
  has_many :networks
  validates :country, presence: true
  validates :dob, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #
  # User's age from date of birth
  #
  def age
    ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
  end
end
