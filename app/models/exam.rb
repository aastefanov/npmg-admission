class Exam < ActiveRecord::Base
  has_and_belongs_to_many :grades
  has_many :assessments
  
  validates_presence_of :name
  validates_presence_of :held_in
end
