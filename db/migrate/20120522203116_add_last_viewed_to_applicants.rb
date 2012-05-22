class AddLastViewedToApplicants < ActiveRecord::Migration
  def up
    add_column :applicants, :last_viewed, :datetime
  end

  def down
    remove_column :applicants, :last_viewed
  end
end
