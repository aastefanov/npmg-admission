# encoding: UTF-8

module RailsAdmin
  class ApprovalController < RailsAdmin::ApplicationController
    include ActionView::Helpers::TextHelper
    include RailsAdmin::MainHelper
    include RailsAdmin::ApplicationHelper

    layout "rails_admin"

    def index
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Удобрение на онлайн документи"
    end

    def preview
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Удобрение на онлайн документи"

      @applicant = Applicant.order(:id).limit(1).joins(:enrollment_assessments, :assets).not_viewed.unapproved.readonly(false)
      if @applicant.length == 0
        flash[:notice] = "Няма неотворени регистрации за удобрение."
        redirect_to Rails.application.routes.url_helpers.rails_admin_approval_path
        return
      end
      @applicant = @applicant.first
      @applicant.last_viewed = DateTime.now
      # @applicant.save
    end

    def change_state
      @authorization_adapter.try(:authorize, :index, @abstract_model, @object)
      @page_name = "Удобрение на онлайн документи"
    end
  end
end
