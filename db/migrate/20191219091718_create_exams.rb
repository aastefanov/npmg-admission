class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :name, null: false
      t.datetime :held_in, null: false

      t.timestamps
    end
  end
end
