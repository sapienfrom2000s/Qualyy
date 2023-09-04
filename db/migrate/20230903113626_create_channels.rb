class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.string :identifier
      t.belongs_to :user
      t.belongs_to :filter

      t.timestamps
    end
  end
end
