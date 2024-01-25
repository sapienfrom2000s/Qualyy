# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :identifier
      t.integer :duration
      t.date :published_on
      t.string :title
      t.integer :views
      t.integer :comments
      t.integer :likes
      t.integer :dislikes
      t.integer :rating
      t.belongs_to :user

      t.timestamps
    end
  end
end
