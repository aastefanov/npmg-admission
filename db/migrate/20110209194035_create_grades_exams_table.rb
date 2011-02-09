class CreateGradesExamsTable < ActiveRecord::Migration
  def self.up
    create_table :grades_students, :id => false do |t|
      t.integer :exam_id
      t.integer :grade_id
    end
  end

  def self.down
    drop_table :grades_students
  end
end
