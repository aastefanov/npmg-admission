class AddStudentIdToApplicants < ActiveRecord::Migration
  def up
    add_column :applicants, :student_id, :integer
    add_column :students, :registered_online, :boolean

    add_index :applicants, :student_id
  end

  def down
    remove_column :applicants, :student_id
    remove_column :students, :registered_online
  end
end
