class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.references :region, foreign_key: true, null: false

      t.timestamps
    end
  end
end
