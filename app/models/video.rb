class Video < ApplicationRecord
  belongs_to :channel
  has_one :user, through: :channel
end
