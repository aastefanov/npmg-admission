# encoding: UTF-8

module RailsAdmin
  class MiscellaneousController < RailsAdmin::ApplicationController
    include ActionView::Helpers::TextHelper
    include RailsAdmin::MainHelper
    include RailsAdmin::ApplicationHelper

    layout "rails_admin"

    def index
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Разни"
    end

    def export_applicants
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Разни"

      applicants = Applicant.where("applicants.student_id IS NULL")
      count = 0
      semi_errors = []
      errors = []
      applicants.each do |applicant|
        begin
          result = applicant.export_to_student
          count += 1 if result == 2
          errors << ["Документи с ЕГН " + applicant.egn, "Подал е оценка, която не се признава, а не е отметнато, че ще се яви на изпит!"] if result == 1
        rescue ActiveRecord::RecordInvalid => e
          errors << ["Документи с ЕГН " + applicant.egn, e.to_s]
        end
      end
      
      if errors.length > 0
        flash[:error] = "Грешки: " + errors.inspect
      end

      if count == applicants.count
        flash[:notice] = "Всички #{count} онлайн документи бяха финализирани."
      else
        flash[:notice] = "#{applicants.count - count} от #{applicants.count} не бяха финализирани, защото не са одобрени или вече са финализирани."
      end
      redirect_to Rails.application.routes.url_helpers.rails_admin_misc_path
    end

    def applicants_close
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Разни"

      Configurable.create!(:name => 'applicants_closed', :value => true)
      flash[:notice] = "Успешно затворихте онлайн регистрацията!"
      redirect_to Rails.application.routes.url_helpers.rails_admin_misc_path
    end

    def view_results
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Разни"

      Configurable.create!(:name => 'view_results', :value => true)
      flash[:notice] = "Успешно включихте уеб интерфейса за преглед на резултати!"
      redirect_to Rails.application.routes.url_helpers.rails_admin_misc_path
    end

    # Format: competition_id, to_range, mark
    def points_marks_import
      @authorization_adapter.try(:authorize, :import, @abstract_model, @object)
      @errors = []
      @i = 0
      unless params[:csv].nil?
      begin
        CSV.parse(params[:csv].read) do |row|
          record = PointsToMark.new :competition_id => row[0], :to_range => row[1], :mark => row[2]
          
          unless record.save
            @errors << [row[0], row[1], row[2]]
          else
            @i += 1
          end
        end
      rescue CSV::MalformedCSVError
        flash[:error] = "Грешно форматиран файл!"
        redirect_to Rails.application.routes.url_helpers.rails_admin_misc_path
        return
      end
      end

      if @errors.size == 0
        flash[:notice] = "Успешно създадохте #{@i} нови записа."
        redirect_to Rails.application.routes.url_helpers.rails_admin_misc_path
        return
      else
        flash[:error] = "Възникнаха грешки при създаването на #{@errors.size} нови записа."
      end

      @page_name = "Автоматизирано въвеждане на точки-оценки"
    end
  end
end
