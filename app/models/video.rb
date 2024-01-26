# frozen_string_literal: true

class Video < ApplicationRecord
  belongs_to :channel, primary_key: :identifier
  belongs_to :album
end
