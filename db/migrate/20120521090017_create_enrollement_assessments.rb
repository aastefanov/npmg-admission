class CreateEnrollementAssessments < ActiveRecord::Migration
  def change
    create_table :enrollement_assessments do |t|
      t.references :applicant
      t.integer :points
      t.references :competition
      t.references :exam
      t.boolean :is_taking_exam
    end
    add_index :enrollement_assessments, :applicant_id
    add_index :enrollement_assessments, :competition_id
    add_index :enrollement_assessments, :exam_id
  end
end
