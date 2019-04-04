class CreateJoinTableStudentExam < ActiveRecord::Migration[5.2]
  def change
    create_join_table :students, :exams do |t|
      # t.index [:student_id, :exam_id]
      # t.index [:exam_id, :student_id]
    end
  end
end
