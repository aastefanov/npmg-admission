class AddFikNumberToAssessments < ActiveRecord::Migration
  def self.up
  	add_column :assessments, :fik_number, :string
  end

  def self.down
  	remove_column :assessments, :fik_number
  end
end
