# frozen_string_literal: true

class Dropfilterstable < ActiveRecord::Migration[7.0]
  def change
    drop_table(:filters, force: :cascade)
  end
end
