class FixEgnApplicantBug < ActiveRecord::Migration
  def up
    remove_column :applicants, :egn
    add_column :applicants, :egn, :string
  end

  def down
    remove_column :applicants, :egn
    add_column :applicants, :egn, :integer
  end
end
