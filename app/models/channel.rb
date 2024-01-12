class Channel < ApplicationRecord
  has_many :videos, primary_key: :identifier
  belongs_to :user
end
