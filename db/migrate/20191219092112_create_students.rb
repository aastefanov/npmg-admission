class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.integer :ref_num, unique: true, where: '([ref_num] IS NOT NULL)'
      t.references :school, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamp :approved_at
      t.timestamp :declined_at

      t.boolean :personal_data, default: true

      t.timestamps
    end

    add_index :students, :ref_num, unique: true, where: '([ref_num] IS NOT NULL)'
  end
end
