# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    add_reference :categories, :user, foreign_key: true
    add_reference :channels, :category, foreign_key: true
  end
end
