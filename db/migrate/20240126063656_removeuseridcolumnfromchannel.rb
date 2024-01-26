class Removeuseridcolumnfromchannel < ActiveRecord::Migration[7.0]
  def change
    remove_column :channels, :user_id
  end
end
