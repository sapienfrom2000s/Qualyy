class Renamecategoriestoalbums < ActiveRecord::Migration[7.0]
  def change
    rename_table :categories, :albums
    rename_column :channels, :category_id, :album_id
  end
end
