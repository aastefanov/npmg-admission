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
      @object = Assessment.where(:student_id => params[:student_id]).where(:exam_id => params[:exam_id]).first
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
        render :action => :edit, :layout => 'rails_admin/form'
      end
    end
  end
end
