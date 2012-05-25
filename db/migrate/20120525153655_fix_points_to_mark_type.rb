class FixPointsToMarkType < ActiveRecord::Migration
  def up
    remove_column :points_to_marks, :to_range
    add_column :points_to_marks, :to_range, :decimal, :precision => 4, :scale => 3 
  end

  def down
    remove_column :points_to_marks, :to_range
    add_column :points_to_marks, :to_range, :integer
  end
end
