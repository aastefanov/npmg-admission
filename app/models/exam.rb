class Exam < ApplicationRecord
  validates_presence_of :name, :held_in

  has_many :exam_rooms
  has_many :rooms, :through => :exam_rooms

  has_many :student_exams
  has_many :students, :through => :student_exams
end
