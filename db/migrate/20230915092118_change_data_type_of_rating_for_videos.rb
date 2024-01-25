# frozen_string_literal: true

class ChangeDataTypeOfRatingForVideos < ActiveRecord::Migration[7.0]
  def change
    change_column :videos, :rating, :float
  end
end
