class Competition < ActiveRecord::Base
  belongs_to :exam
  has_many :points_to_marks
  has_many :enrollment_assessments

  validates_presence_of :name, :exam_id

  attr_accessible :name, :exam_id
end
