class AddStudentGender < ActiveRecord::Migration
  def self.up
    add_column :students, :is_girl, :boolean, :default => false
  end

  def self.down
    remove_column :students, :is_girl
  end
end
