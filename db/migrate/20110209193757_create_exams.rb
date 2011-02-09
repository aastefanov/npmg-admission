class CreateExams < ActiveRecord::Migration
  def self.up
    create_table :exams do |t|
      t.string :name
      t.date :held_in
    end
  end

  def self.down
    drop_table :exams
  end
end
