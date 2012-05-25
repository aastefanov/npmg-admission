# encoding: UTF-8

module RailsAdmin
  class ApprovalController < RailsAdmin::ApplicationController
    include ActionView::Helpers::TextHelper
    include RailsAdmin::MainHelper
    include RailsAdmin::ApplicationHelper

    layout "rails_admin"

    def index
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Одобрение на онлайн документи"
    end

    def preview
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Одобрение на онлайн документи"

      @applicant = Applicant.not_viewed.unapproved.joins(:enrollment_assessments, :assets).order(:id).limit(1).readonly(false)
      if @applicant.length == 0
        flash[:notice] = "Няма неотворени регистрации за одобрение."
        redirect_to Rails.application.routes.url_helpers.rails_admin_approval_path
        return
      end
      @applicant = @applicant.first
      @applicant._no_view_date = true
      @applicant.last_viewed = DateTime.now
      @applicant.save
    end

    def change_state
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Одобрение на онлайн документи"

      if params[:_edit]
        redirect_to "/adnp/applicant/#{params[:id]}/edit"
        return
      else
        @applicant = Applicant.find(params[:id])
        if params[:_approve]
          @applicant._approve = true
          flash[:notice] = "Успешно одобрихте регистрация."
        else
          if params[:review].nil? || params[:review].length < 1
            flash[:error] = "Не сте въвел забележка."
            @applicant.last_viewed = DateTime.now - 2.hour
            @applicant.save
            redirect_to Rails.application.routes.url_helpers.rails_admin_approval_path
            return
          end
          @applicant._dissapprove = true
          @applicant.reviews << Review.new(:content => params[:review])
          flash[:notice] = "Успешно отхвърлихте регистрация."
        end
        @applicant.save
        redirect_to Rails.application.routes.url_helpers.rails_admin_approval_path
        return
      end
    end
  end
end
