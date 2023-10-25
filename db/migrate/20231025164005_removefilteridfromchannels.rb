class Removefilteridfromchannels < ActiveRecord::Migration[7.0]
  def change
    remove_column :channels, :filter_id
  end
end
