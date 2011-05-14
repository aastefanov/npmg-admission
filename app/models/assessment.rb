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

  def self.mark_with_words(mark)
    words = case mark.to_f 
      when 0.0 then "Неявил се"
      when 0.001..2.999 then "Слаб"
      when 2.0..3.499 then "Среден"
      when 3.5..4.499 then "Добър"
      when 4.5..5.499 then "Мн. добър"
      when 5.5..6.0 then "Отличен"
    end

    words
  end

  def self.num_with_greater_marks(grade, mark)
    n = Assessment.joins(:exam, "INNER JOIN exams_grades ON exams_grades.exam_id = exams.id", "INNER JOIN grades ON grades.id = exams_grades.grade_id")
    n = n.where("grades.id = #{grade}")
    n = n.select("SUM(GREATEST(COALESCE(assessments.competition_mark, 0), COALESCE(assessments.exam_mark, 0)) > #{mark}) as num")

    return n.first.num
  end
end
