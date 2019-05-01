class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :non_parent

  def non_parent
    if current_user.is_parent?
      flash[:error] = "Нямате достъп до тази страница"
      redirect_back fallback_location: root_path
    end
  end

  def index
    @requests = ApprovalRequest.where(:rejected_at => nil, :approved_at => nil)
  end

  def show
    @request = ApprovalRequest.find(params[:id])
  end

  def approve
    @request = ApprovalRequest.find(params[:id])

    unless @request.is_approved? or @request.is_rejected?
      @request.approved_at = DateTime.now
      @request.respond_user = current_user
      @request.save!
    end

    redirect_to approval_path @request
  end

  def reject
    @request = ApprovalRequest.find(params[:id])

    unless @request.is_approved? or @request.is_rejected?
      @request.rejected_at = DateTime.now
      @request.respond_user = current_user
      @request.save!
    end

    redirect_to approval_path @request
  end

  def comment
    comment = ApprovalComment.new :approval_request_id => params[:approval_id],
                                  :user => current_user,
                                  :content => params[:approval_comment][:content]
    comment.save!

    redirect_to approval_path params[:approval_id]
  end
end