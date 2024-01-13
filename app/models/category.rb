class Category < ApplicationRecord
  belongs_to :user
  has_many :channels
  has_many :videos, through: :channels
end
