class AddTitleToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :title, null: true
    end
  end
end
