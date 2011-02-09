class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :egn
      t.string :ref_number
      t.string :phone
      t.string :email
      t.string :address
      t.integer :registered_by

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
