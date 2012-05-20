class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.references :applicant

      t.timestamps
    end
    add_index :reviews, :applicant_id
  end
end
