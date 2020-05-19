class CreateAppSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :app_settings do |t|
      t.string :key, index: {unique: true}, null: false
      t.string :value, null: true
    end
  end
end
