class CreateStudentExams < ActiveRecord::Migration[5.2]
  def change
    create_table :student_exams do |t|
      t.references :exam, foreign_key: true, null: false
      t.references :student, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: true

      t.index [:exam_id, :student_id], unique: true

      t.timestamps
    end
  end
end
