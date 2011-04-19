class Assessment < ActiveRecord::Base
  belongs_to :exam
  belongs_to :student


  def self.build(exam)
  	assessment = Assessment.new
  	assessment.exam = exam
  	assessment
  end

  def final_mark
  	(exam_mark || 0) > (competition_mark || 0) ? exam_mark : competition_mark
  end

  attr_protected :id
end
