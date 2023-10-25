class Channel < ApplicationRecord
  validates :identifier, length: { in: 1..25 }
  belongs_to :user
end
