class Assessment < ActiveRecord::Base
  belongs_to :exam
  belongs_to :student


  def self.build(exam)
  	assessment = Assessment.new
  	assessment.exam = exam
  	assessment
  end

  attr_protected :id
end
