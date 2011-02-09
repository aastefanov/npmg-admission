class CreateStudentsGradesTable < ActiveRecord::Migration
  def self.up
    create_table :students_grades, :id => false do |t|
      t.integer :student_id
      t.integer :grade_id
    end
  end

  def self.down
    drop_table :students_grades
  end
end
