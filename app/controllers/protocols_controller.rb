class ProtocolsController < ApplicationController
  def index
  end

  def all
    @personal_data = params[:personal_data] || false
    @results = ExamResult.find_by_exam_id(params[:exam_id])
    @exam = Exam.find(params[:exam_id])
  end

  def top
    #@results = ExamResult.find_by_exam_id(params[:exam_id]).rank
    #@exam = Exam.find(params[:exam_id])

    # TODO: Do not use custom SQL
    sql = """SELECT *
FROM (SELECT id,
             COALESCE(pts_arbitrage, (pts_grader1 + pts_grader2) / 2)                         AS score,
             RANK() OVER (PARTITION BY exam_id ORDER BY (pts_grader1 + pts_grader2) / 2 DESC) AS place
      FROM exam_results p
     ) r
WHERE place <= 3
ORDER BY place;
"""

    @res = ApplicationRecord.connection.exec_query(sql)
    @final = @res.map { |r|
      exam_result = ExamResult.find(r.id)
      place = r.place
    }
  end

  def result_params
    params.require(:exam).permit(:id)
  end
end
