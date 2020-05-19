class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.references :exam, foreign_key: true, null: false
      t.integer :fik_num, null: false
      t.decimal :grade_first, null: false
      t.decimal :grade_second, null: false
      t.decimal :grade_arbitrage

      # Reference to `students`.`ref_num`
      t.integer :ref_num, foreign_key: {:to_table => :students, :primary_key => :ref_num}, null: false

      # Exam first - used in reports
      t.index [:exam, :ref_num], unique: true
      t.timestamps
    end

  end
end
