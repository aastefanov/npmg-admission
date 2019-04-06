class AddReviewsToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :review, :text
    add_column :students, :is_approved, :boolean
  end
end
