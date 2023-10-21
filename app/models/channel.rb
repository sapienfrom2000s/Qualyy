class Channel < ApplicationRecord
  validates :identifier, length: { in: 1..25 }
  belongs_to :filter, inverse_of: :channel
  accepts_nested_attributes_for :filter  
  belongs_to :user
end
