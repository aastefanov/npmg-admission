# encoding: UTF-8

module RailsAdmin
  class DeclassificationController < RailsAdmin::ApplicationController
    include ActionView::Helpers::TextHelper
    include RailsAdmin::MainHelper
    include RailsAdmin::ApplicationHelper

    layout "rails_admin"

    def index
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Разсекратяване"
      @exams = Exam.all
    end

    def edit
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @object = Assessment.where(:student_id => params[:student_id]).where(:exam_id => params[:exam_id]).where(:is_taking_exam => true).first
      unless @object
        flash[:error] = "Няма ученик, който да се явява на този изпит!"
        redirect_to Rails.application.routes.url_helpers.rails_admin_declass_path
        return
      end

      @page_name = "Разсекратяване"

    end

    def update
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @object = Assessment.find(params[:assessment][:id])

      if @object.update_attributes(params[:assessment])
        flash[:notice] = "Успешно разсекретихте резултат."
        redirect_to Rails.application.routes.url_helpers.rails_admin_declass_path(:exam_id => @object.exam_id)
      else
        flash[:error] = "Възникна грешка при валидацията!"
        if @object.fik_number
          @object.errors[:fik_number] = "Трябва да бъде въведен." if @object.fik_number.size < 1
        end
        render :action => :edit
      end
    end

    # Format: exam_id, student_id, fik_number, exam_mark
    def import
      @authorization_adapter.try(:authorize, :import, @abstract_model, @object)
      @errors = []
      @i = 0
      unless params[:csv].nil?
      begin
        CSV.parse(params[:csv].read) do |row|
          student = Assessment.where(:student_id => row[1]).where(:exam_id => row[0]).where(:is_taking_exam => true).first
          unless student
            @errors << [row[0], row[1], false]
            next
          end

          student.fik_number = row[2]
          student.exam_mark = row[3]
          
          unless student.save
            @errors << [row[0], row[1], true]
          else
            @i += 1
          end
        end
      rescue CSV::MalformedCSVError
        flash[:error] = "Грешно форматиран файл!"
        redirect_to Rails.application.routes.url_helpers.rails_admin_declass_path
        return
      end
      end

      if @errors.size == 0
        flash[:notice] = "Успешно разсекретихте #{@i} работи."
        redirect_to Rails.application.routes.url_helpers.rails_admin_declass_path
        return
      else
        flash[:error] = "Възникнаха грешки при разсекретяването на #{@errors.size} работи."
      end

      @page_name = "Автоматизирано разсекратяване"
    end
  end
end
