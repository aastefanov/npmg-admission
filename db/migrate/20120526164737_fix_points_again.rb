class FixPointsAgain < ActiveRecord::Migration
  def up
    change_column :enrollment_assessments, :points, :decimal, :precision => 16, :scale => 3
  end

  def down
    change_column :enrollment_assessments, :points, :integer
  end
end
