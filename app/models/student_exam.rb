class StudentExam < ApplicationRecord
  belongs_to :exam
  belongs_to :student
  belongs_to :room, required: false
  # has_one :room, required: false

  validates_presence_of :exam, :student

  has_many :exam_rooms, ->(se) {
    unscope(:where).where("exam_id = :exam_id AND room_id = :room_id",
                          exam_id: se.exam_id, room_id: se.room_id)
  }
end
