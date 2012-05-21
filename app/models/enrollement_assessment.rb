# encoding: UTF-8

class EnrollementAssessment < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :competition
  belongs_to :exam

  validates_presence_of :exam_id
  before_validation :validate_special

  def validate_special
    if competition_mark.nil? and !is_taking_exam?
      errors[:is_taking_exam] << "Ученикът трябва или да има оценка от олимпиада или да се яви на изпит!"
    end
  end
end
