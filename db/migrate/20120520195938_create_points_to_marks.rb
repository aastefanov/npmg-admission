class CreatePointsToMarks < ActiveRecord::Migration
  def change
    create_table :points_to_marks do |t|
      t.integer :from_range
      t.integer :to_range
      t.decimal :mark
      t.references :competition

      t.timestamps
    end
    add_index :points_to_marks, :competition_id
  end
end
