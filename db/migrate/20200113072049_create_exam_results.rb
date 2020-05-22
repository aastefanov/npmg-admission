class CreateExamResults < ActiveRecord::Migration[5.2]
  def change
    create_table :exam_results do |t|
      t.references :exam, foreign_key: true, null: false
      t.references :student, foreign_key: true, null: false

      t.integer :fik_num

      t.integer :pts_grader1
      t.integer :pts_grader2
      t.integer :pts_arbitrage

      t.index [:exam_id, :student_id], unique: true
      t.timestamps
    end
  end
end
