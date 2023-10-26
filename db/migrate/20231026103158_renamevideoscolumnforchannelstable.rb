class Renamevideoscolumnforchannelstable < ActiveRecord::Migration[7.0]
  def change
    rename_column :channels, :videos, :no_of_videos
  end
end
