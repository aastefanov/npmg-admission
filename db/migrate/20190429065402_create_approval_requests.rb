class CreateApprovalRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :approval_requests do |t|
      t.integer :respond_user_id
      t.datetime :approved_at
      t.datetime :rejected_at

      t.integer :student_id

      t.index :student_id
      t.timestamps
    end


  end
end
