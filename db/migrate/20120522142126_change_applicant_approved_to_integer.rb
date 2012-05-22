class ChangeApplicantApprovedToInteger < ActiveRecord::Migration
  def up
    remove_column :applicants, :approved
    add_column :applicants, :approved, :integer
  end

  def down
    remove_column :applicants, :approved
    add_column :applicants, :approved, :boolean
  end
end
