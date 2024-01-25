# frozen_string_literal: true

class Changechannelidtypeforvideos < ActiveRecord::Migration[7.0]
  def change
    remove_reference(:videos, :channel, foreign_key: { to_table: :channels })
    add_reference(:videos, :channel, type: :string)
    add_index(:channels, [:identifier], unique: true)
    add_foreign_key(:videos, :channels, column: :channel_id, primary_key: 'identifier')
  end
end
