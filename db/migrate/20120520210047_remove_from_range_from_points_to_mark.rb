class RemoveFromRangeFromPointsToMark < ActiveRecord::Migration
  def up
    remove_column :points_to_marks, :from_range
  end

  def down
    add_column :points_to_marks, :from_range, :integer
  end
end
