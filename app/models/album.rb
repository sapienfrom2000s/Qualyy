class Album < ApplicationRecord
  belongs_to :user
  has_many :channels, dependent: :destroy
  has_many :videos, through: :channels
end
