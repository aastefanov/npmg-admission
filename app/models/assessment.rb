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
end
