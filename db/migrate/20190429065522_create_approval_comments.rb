class CreateApprovalComments < ActiveRecord::Migration[5.2]
  def change
    create_table :approval_comments do |t|
      t.integer :approval_request_id, null: false
      t.integer :user_id, null: false
      t.text :content, null: false

      t.timestamps

      t.index :approval_request_id
      t.index :user_id
      t.timestamps
    end
  end
end
