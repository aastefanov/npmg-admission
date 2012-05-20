class FixPointsToMark < ActiveRecord::Migration
  def up
    remove_column :points_to_marks, :mark
    add_column :points_to_marks, :mark, :decimal, :precision => 4, :scale => 3 
  end

  def down
    remove_column :points_to_marks, :mark
    add_column :points_to_marks, :mark, :decimal
  end
end
