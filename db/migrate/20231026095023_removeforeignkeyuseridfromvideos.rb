# frozen_string_literal: true

class Removeforeignkeyuseridfromvideos < ActiveRecord::Migration[7.0]
  def change
    remove_index :videos, :user_id
    remove_column :videos, :user_id
  end
end
