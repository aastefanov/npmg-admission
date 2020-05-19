class CreateExamResults < ActiveRecord::Migration[5.2]
  def change
    create_table :exam_results do |t|
      t.references :exam, foreign_key: true
      t.integer :pts_grader1
      t.integer :pts_grader2
      t.integer :pts_arbitrage

      t.integer :ref_num
      t.foreign_key :students, column: :ref_num, primary_key: :ref_num, foreign_key: {to_table: :students, column: :ref_num}
      #t.integer :ref_num, null: false, index: true

      t.timestamps
    end
  end
end
