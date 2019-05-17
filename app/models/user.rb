class User < ApplicationRecord
  has_many :networks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
