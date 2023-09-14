require 'faraday'

class Video < ApplicationRecord
  belongs_to :user
end
