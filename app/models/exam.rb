class Exam < ActiveRecord::Base
  has_and_belongs_to_many :grades
  has_and_belongs_to_many :students
end
