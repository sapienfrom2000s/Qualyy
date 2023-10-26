class Addreferencesofchannelstovideos < ActiveRecord::Migration[7.0]
  def change
    add_reference(:videos, :channel, foreign_key: { to_table: :channels })
  end
end
