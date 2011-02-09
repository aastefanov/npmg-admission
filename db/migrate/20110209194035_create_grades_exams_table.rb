class CreateGradesExamsTable < ActiveRecord::Migration
  def self.up
    create_table :exams_grades, :id => false do |t|
      t.integer :exam_id
      t.integer :grade_id
    end
  end

  def self.down
    drop_table :exams_grades
  end
end
