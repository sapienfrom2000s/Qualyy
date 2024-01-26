# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, on: :create
  validates :youtube_api_key, presence: true

  validates :youtube_api_key, length: { in: 1..50 }

  has_many :albums, dependent: :destroy

  # no need of this association(maybe)
  has_many :channels, through: :albums, dependent: :destroy
  has_many :videos, through: :channels
end
