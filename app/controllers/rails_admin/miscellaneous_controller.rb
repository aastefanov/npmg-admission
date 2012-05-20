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
