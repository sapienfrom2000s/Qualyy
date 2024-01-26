class ChangeDatatypeChannelidInVideos < ActiveRecord::Migration[7.0]
  def change
    remove_reference :videos, :channel, index: true, foreign_key: true
    add_column :videos, :channel_id, :string
    add_foreign_key :videos, :channels, column: :channel_id, primary_key: "identifier"
  end
end
