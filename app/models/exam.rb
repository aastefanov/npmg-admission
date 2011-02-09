class Exam < ActiveRecord::Base
  has_and_belongs_to_many :grades
  has_many :assessments
end
