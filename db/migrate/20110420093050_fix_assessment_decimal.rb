class FixAssessmentDecimal < ActiveRecord::Migration
  def self.up
  	remove_column :assessments, :exam_mark
  	add_column :assessments, :exam_mark, :decimal, :precision => 4, :scale => 3 
  	remove_column :assessments, :competition_mark
  	add_column :assessments, :competition_mark, :decimal, :precision => 4, :scale => 3
  end

  def self.down
  	remove_column :assessments, :exam_mark
  	add_column :assessments, :exam_mark, :decimal
  	remove_column :assessments, :competition_mark
  	add_column :assessments, :competition_mark, :decimal
  end
end
