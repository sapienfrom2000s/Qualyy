# frozen_string_literal: true

class Removefilterindexfromchannels < ActiveRecord::Migration[7.0]
  def change
    remove_index :channels, :filter_id
  end
end
