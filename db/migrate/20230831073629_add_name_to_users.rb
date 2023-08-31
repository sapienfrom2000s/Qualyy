class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :youtube_api_key, :string, null: false, default: ""
  end
end
