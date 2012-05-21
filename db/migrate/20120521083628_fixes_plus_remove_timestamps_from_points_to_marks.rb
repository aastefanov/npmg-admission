class FixesPlusRemoveTimestampsFromPointsToMarks < ActiveRecord::Migration
  def up
    remove_column :points_to_marks, :created_at
    remove_column :points_to_marks, :updated_at
    remove_column :assets, :created_at
    remove_column :assets, :updated_at
    remove_column :competitions, :created_at
    remove_column :competitions, :updated_at
    remove_column :applicants, :approved
    add_column :applicants, :approved, :boolean

    add_index :points_to_marks, :to_range
    add_index :applicants, :approved
    add_index :assessments, :is_taking_exam
    add_index :assessments, :exam_id
    add_index :assessments, :student_id
    add_index :exams_grades, :exam_id
    add_index :exams_grades, :grade_id
    add_index :students_grades, :student_id
    add_index :students_grades, :grade_id
  end

  def down
    add_column :points_to_marks, :created_at, :datetime
    add_column :points_to_marks, :updated_at, :datetime
    add_column :assets, :created_at, :datetime
    add_column :assets, :updated_at, :datetime
    add_column :competitions, :created_at, :datetime
    add_column :competitions, :updated_at, :datetime
    remove_column :applicants, :approved
    add_column :applicants, :approved, :integer
  end
end
