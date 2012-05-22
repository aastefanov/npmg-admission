class RenameVersionApplicant < ActiveRecord::Migration
  def up
    remove_column :applicants, :version
    add_column :applicants, :version_n, :integer
  end

  def down
    remove_column :applicants, :version_n
    add_column :applicants, :version, :integer
  end
end
