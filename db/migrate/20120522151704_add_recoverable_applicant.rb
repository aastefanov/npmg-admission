class AddRecoverableApplicant < ActiveRecord::Migration
  def up
    add_column :applicants, :reset_password_token, :string
    add_column :applicants, :reset_password_sent_at, :datetime
  end

  def down
    remove_column :applicants, :reset_password_token
    remove_column :applicants, :reset_password_token_at
  end
end
