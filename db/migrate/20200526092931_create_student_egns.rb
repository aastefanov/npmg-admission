class CreateStudentEgns < ActiveRecord::Migration[5.2]
  def change
    create_table :student_egns do |t|
      t.references :student, foreign_key: true, null: false, unique: true
      t.column :egn, 'char(10)', null: false, index: true

      t.timestamps
    end
  end
end
