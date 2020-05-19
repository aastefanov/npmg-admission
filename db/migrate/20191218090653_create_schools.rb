class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.integer :admin_id, null: false
      t.references :city, foreign_key: true, null: false

      t.timestamps
    end

    add_index :schools, :admin_id, unique: true
  end
end
