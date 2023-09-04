class Channel < ApplicationRecord
  validates :identifier, length: { in: 1..25 }
  belongs_to :filter
  belongs_to :user
end
