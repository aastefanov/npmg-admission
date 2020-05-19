class CreateExamRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :exam_rooms do |t|
      t.references :exam, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: false

      t.index [:exam_id, :room_id], unique: true

      t.integer :priority, default: 1

      t.timestamps
    end
  end
end
