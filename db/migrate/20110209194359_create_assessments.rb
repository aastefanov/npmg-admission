class CreateAssessments < ActiveRecord::Migration
  def self.up
    create_table :assessments do |t|
      t.integer :exam_id
      t.integer :student_id
      t.decimal :exam_mark
      t.decimal :competition_mark
      t.boolean :is_taking_exam
    end
  end

  def self.down
    drop_table :assessments
  end
end
