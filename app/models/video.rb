require 'faraday'

class Video < ApplicationRecord
  belongs_to :channel
end
