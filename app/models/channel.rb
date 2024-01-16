class Channel < ApplicationRecord
  has_many :videos, primary_key: :identifier, dependent: :destroy
  belongs_to :user
  belongs_to :category
end
