class AddClassNameToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :class_name, :string
  end
end
