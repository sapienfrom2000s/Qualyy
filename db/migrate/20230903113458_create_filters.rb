class CreateFilters < ActiveRecord::Migration[7.0]
  def change
    create_table :filters do |t|
      t.date :published_before
      t.date :published_after
      t.text :keywords
      t.text :non_keywords
      t.integer :minimum_duration, :null => false, :default => 0
      t.integer :maximum_duration, :null => false, :default => 14400
      t.integer :videos
      
      t.timestamps
    end
  end
end
