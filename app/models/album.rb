# frozen_string_literal: true

class Album < ApplicationRecord
  belongs_to :user
  has_many :channels, dependent: :destroy
  has_many :videos, dependent: :destroy
end
