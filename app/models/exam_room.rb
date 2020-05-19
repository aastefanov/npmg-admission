class ExamRoom < ApplicationRecord
  belongs_to :exam
  belongs_to :room

  validates_presence_of :exam, :room

  has_many :student_exams, ->(er) {
    unscope(:where).where("exam_id = :exam_id AND room_id = :room_id",
                          exam_id: er.exam_id, room_id: er.room_id)
  }
end
