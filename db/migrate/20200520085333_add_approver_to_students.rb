class AddApproverToStudents < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :approver, foreign_key: {to_table: :users}, null: true
  end
end
