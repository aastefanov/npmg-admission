class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :region
      t.string :municipality
      t.string :city
    end
  end
end
