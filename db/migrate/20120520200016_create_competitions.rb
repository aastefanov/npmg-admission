class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.references :exam

      t.timestamps
    end
    add_index :competitions, :exam_id
  end
end
