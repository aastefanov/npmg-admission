# encoding: UTF-8

module RailsAdmin
  class AssessmentsController < RailsAdmin::ApplicationController
    include ActionView::Helpers::TextHelper
    include RailsAdmin::MainHelper
    include RailsAdmin::ApplicationHelper

    layout "rails_admin"


    def index
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Протоколи"
      @exams = Exam.all
      @grades = Grade.all
    end

    def exam_protocol
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)

      @exam = Exam.find(params[:exam_id])
      @assessments = Assessment.where(:exam_id => params[:exam_id], :is_taking_exam => true).order(:student_id)
      @filename = "exam_#{params[:exam_id]}_protocol.csv"
      @output_encoding = 'windows-1251'
      @csv_options = { :force_quotes => true, :col_sep => ';' }
    
      respond_to do |format|
        format.csv
      end
   end

   def inspector_protocol
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)

      @grade = Grade.find(params[:grade_id])
      @assessments = Assessment.joins(:student, :exam, "INNER JOIN exams_grades ON exams_grades.exam_id = exams.id AND exams_grades.grade_id = #{params[:grade_id]}", "INNER JOIN students_grades ON students_grades.student_id = students.id AND students_grades.grade_id = exams_grades.grade_id")
      @assessments = @assessments.select("assessments.student_id, students.first_name, students.middle_name, students.last_name, students.egn, assessments.fik_number, GREATEST(COALESCE(assessments.competition_mark, 0), COALESCE(assessments.exam_mark, 0)) as final_m")
      @assessments = @assessments.order("assessments.student_id, final_m DESC")
      @filename = "inspector_#{params[:grade_id]}_protocol.csv"
      @output_encoding = 'windows-1251'
      @csv_options = { :force_quotes => true, :col_sep => ';' }
    
      respond_to do |format|
        format.csv
      end
   end

    def all_students
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)

      @grades = Grade.all
      @students = Student.all
      @assessments = {}
      @students.each do |student|
        @assessments[student.id.to_i] = {}
        asses = Assessment.joins(:exam, "INNER JOIN exams_grades ON exams_grades.exam_id = exams.id").
          where("assessments.student_id = #{student.id}").
          group("exams_grades.grade_id").
          select("exams_grades.grade_id as grade_id, assessments.exam_id, assessments.student_id, assessments.fik_number, MAX(GREATEST(COALESCE(assessments.competition_mark, 0), COALESCE(assessments.exam_mark, 0))) as final_m")
        asses.each do |a|
          @assessments[student.id.to_i][a.grade_id.to_i] = a
        end
      end

      @filename = "all_students_protocol.csv"
      @output_encoding = 'windows-1251'
      @csv_options = { :force_quotes => true, :col_sep => ';' }
    
      respond_to do |format|
        format.csv
      end
    end
  end
end
