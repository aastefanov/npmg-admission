class Exam < ActiveRecord::Base
  has_and_belongs_to_many :grades
  has_many :assessments, :dependent => :destroy
  has_many :enrollment_assessments, :dependent => :destroy
  has_paper_trail
  
  validates_presence_of :name
  validates_presence_of :held_in
end
