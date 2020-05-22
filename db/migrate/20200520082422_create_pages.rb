class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :name, index: true, null: false, unique: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
