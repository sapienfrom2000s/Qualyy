# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :videos, primary_key: :identifier, dependent: :destroy
  belongs_to :album
end
