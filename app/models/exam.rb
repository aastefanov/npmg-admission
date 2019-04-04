class Exam < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :held_in

  has_and_belongs_to_many :students
end
