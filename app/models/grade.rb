class Grade < ActiveRecord::Base
  has_and_belongs_to_many :exams
  has_and_belongs_to_many :students, :join_table => :students_grades
  
  validates_presence_of :name
end
