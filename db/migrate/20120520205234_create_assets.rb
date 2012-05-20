class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :description
      t.references :applicant

      t.timestamps
    end
    add_index :assets, :applicant_id
  end
end
