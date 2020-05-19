class Room < ApplicationRecord
  has_many :exam_rooms
  has_many :exams, :through => :exam_rooms

  has_many :student_exams
end
