class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :egn
      t.integer :phone
      t.string :email
      t.string :encrypted_password
      t.string :password_salt
      t.integer :version
      t.integer :approved

      t.timestamps
    end
  end
end
