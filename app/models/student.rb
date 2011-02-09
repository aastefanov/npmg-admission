class Student < ActiveRecord::Base
  has_and_belongs_to_many :grades
  has_many :assessments
  has_many :exams, :through => :assessments
end
