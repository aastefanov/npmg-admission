module RailsAdmin
  class AssessmentsController < RailsAdmin::ApplicationController
    def index
      @authorization_adapter.authorize(:index) if @authorization_adapter
      @page_name = "Протоколи"
      @exams = Exam.all
      @grades = Grade.all

      render :layout => 'rails_admin/list'
    end

    def get_assessments
      @authorization_adapter.authorize(:index) if @authorization_adapter
      
      @assessments = Array.new
      @grade = Grade.find(params[:id])
      @grade.exams.each do |exam|
        @assessments << Assessment.build(exam)
      end
    end

    def exam_protocol
      @authorization_adapter.authorize(:index) if @authorization_adapter

      @assessments = Assessment.where(:exam_id => params[:exam_id])
      @filename = "exam_#{params[:exam_id]}_protocol.csv"
      @output_encoding = 'windows-1251'
      @csv_options = { :force_quotes => true, :col_sep => ';' }
    
      respond_to do |format|
        format.csv
      end
   end

   def inspector_protocol
      @authorization_adapter.authorize(:index) if @authorization_adapter

      @assessments = Assessment.joins(:student, :exam, "INNER JOIN exams_grades ON exams_grades.exam_id = exams.id").group("assessments.student_id, exams_grades.grade_id").select("assessments.student_id, students.first_name, students.middle_name, students.last_name, students.egn, assessments.fik_number, MAX(GREATEST(COALESCE(assessments.competition_mark, 0), COALESCE(assessments.exam_mark, 0))) as final_m")
      @filename = "inspector_#{params[:grade_id]}_protocol.csv"
      @output_encoding = 'windows-1251'
      @csv_options = { :force_quotes => true, :col_sep => ';' }
    
      respond_to do |format|
        format.csv
      end
   end
  end
end
