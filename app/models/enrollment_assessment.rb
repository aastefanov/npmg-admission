# encoding: UTF-8

class EnrollmentAssessment < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :competition
  belongs_to :exam

  validates_presence_of :exam_id
  before_validation :validate_special, :validate_competition
  attr_accessor :_destroy

  def destroy?
    _destroy.to_i == 1
  end

  def validate_special
    self.competition_id = competition_id.to_i

    if (!points.nil? && (competition_id.nil? || competition_id == 0))
      errors[:competition_id] << "Попълнили сте точки, но не и състезание!"
    end

    if (points.nil? && !(competition_id.nil? || competition_id == 0))
      errors[:points] << "Попълнили сте състезание, но не и точки!"
    end

    if (points.nil? || (competition_id.nil? || competition_id == 0)) and !is_taking_exam?
      errors[:is_taking_exam] << "Ученикът трябва или да има точки от олимпиада или да се яви на изпит!"
    end
  end

  def validate_competition
    self.competition_id = competition_id.to_i
    return if competition_id.nil? || competition_id == 0
    if competition.exam_id != exam_id
      errors[:competition_id] << "Оценка от това състезание не може да бъде приложена за избрания изпит."
    end
  end
end
