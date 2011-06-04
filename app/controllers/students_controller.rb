class StudentsController < ApplicationController
  def results
    @screen = true
    @student = Student.where(:id => params[:id]).where(:egn => params[:egn]).includes(:grades).first

    unless @student
      flash[:error] = "Не съществува ученик с данните, въведени от вас! Моля опитайте отново или се свържете с нас."
      redirect_to root_url
      return
    end

      @assessments = Assessment.joins(:exam, "INNER JOIN exams_grades ON exams_grades.exam_id = exams.id", "INNER JOIN grades ON grades.id = exams_grades.grade_id", "INNER JOIN students_grades ON grades.id = students_grades.grade_id")
      @assessments = @assessments.where("students_grades.student_id = #{@student.id}")
      @assessments = @assessments.where("assessments.student_id = #{@student.id}")
      @assessments = @assessments.group("exams_grades.grade_id")
      @assessments = @assessments.select("grades.name as grade_name, grades.id as grade_id, assessments.exam_id, assessments.student_id, assessments.fik_number, MAX(GREATEST(COALESCE(assessments.competition_mark, 0), COALESCE(assessments.exam_mark, 0))) as final_m")
  end
end
