class Addcolumnstochannel < ActiveRecord::Migration[7.0]
  def change
    add_column :channels, :published_before, :date
    add_column :channels, :published_after, :date
    add_column :channels, :keywords, :text
    add_column :channels, :non_keywords, :text
    add_column :channels, :maximum_duration, :integer
    add_column :channels, :minimum_duration, :integer
    add_column :channels, :videos, :integer
  end
end
