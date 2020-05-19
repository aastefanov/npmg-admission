class ExamResult < ApplicationRecord
  belongs_to :exam
  belongs_to :student, foreign_key: :ref_num, primary_key: :ref_num

  def pts_final
    pts_arbitrage || (pts_grader1 + pts_grader2) / 2
  end
end
