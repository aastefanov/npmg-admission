# encoding: UTF-8

module RailsAdmin
  class DeclassificationController < RailsAdmin::ApplicationController

    def index
      @authorization_adapter.authorize(:index, @abstract_model) if @authorization_adapter
      @page_name = "Разсекратяване"
      @exams = Exam.all

      render :layout => 'rails_admin/list'
    end

    def edit
      @authorization_adapter.authorize(:index, @abstract_model) if @authorization_adapter
      @object = Assessment.where(:student_id => params[:student_id]).where(:exam_id => params[:exam_id]).where(:is_taking_exam => true).first
      unless @object
        flash[:error] = "Няма ученик, който да се явява на този изпит!"
        redirect_to rails_admin_declass_path
        return
      end

      @page_name = "Разсекратяване"

      render :layout => 'rails_admin/form'
    end

    def update
      @authorization_adapter.authorize(:index, @abstract_model) if @authorization_adapter
      @object = Assessment.find(params[:assessment][:id])

      if @object.update_attributes(params[:assessment])
        flash[:notice] = "Успешно разсекретихте резултат."
        redirect_to rails_admin_declass_path(:exam_id => @object.exam_id)
      else
        flash[:error] = "Възникна грешка при валидацията!"
        if @object.fik_number
          @object.errors[:fik_number] = "Трябва да бъде въведен." if @object.fik_number.size < 1
        end
        render :action => :edit, :layout => 'rails_admin/form'
      end
    end

    # Format: exam_id, student_id, fik_number, exam_mark
    def import
      @authorization_adapter.authorize(:index, @abstract_model) if @authorization_adapter
      @errors = []
      @i = 0
      unless params[:csv].nil?
      begin
        FasterCSV.parse(params[:csv].read) do |row|
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
      rescue FasterCSV::MalformedCSVError
        flash[:error] = "Грешно форматиран файл!"
        redirect_to rails_admin_declass_path
        return
      end
      end

      if @errors.size == 0
        flash[:notice] = "Успешно разсекретихте #{@i} работи."
        redirect_to rails_admin_declass_path
        return
      else
        flash[:error] = "Възникнаха грешки при разсекретяването на #{@errors.size} работи."
      end

      @page_name = "Автоматизирано разсекратяване"
      render :layout => 'rails_admin/list'
    end
  end
end
