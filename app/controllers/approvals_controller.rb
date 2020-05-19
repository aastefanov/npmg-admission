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
    @requests = Applicant.where(:declined_at => nil, :approved_at => nil)
  end

  def show
    @request = Applicant.find(params[:id])
  end

  def approve
    @request = Applicant.find(params[:id])

    unless @request.is_approved? or @request.is_declined?
      @request.approved_at = DateTime.now
      @request.respond_user = current_user


      @request.student.ref_number = (Student.maximum("ref_number").to_i || 0) + 1

      @request.save!
    end

    StudentsMailer.with(:user => @request.user, :student => @request.student).registration_approved.deliver_now

    redirect_to approval_path @request
  end

  def reject
    @request = ApprovalRequest.find(params[:id])

    unless @request.is_approved? or @request.is_rejected?
      @request.rejected_at = DateTime.now
      @request.respond_user = current_user
      @request.save!
    end

    StudentsMailer.with(:user => @request.user, :student => @request.student).registration_rejected.deliver_now

    redirect_to approval_path @request
  end

  def comment
    comment = ApprovalComment.new :approval_request_id => params[:approval_id],
                                  :user => current_user,
                                  :content => params[:approval_comment][:content]
    comment.save!

    StudentsMailer.with(:user => comment.request.user, :student => comment.request.student).registration_commented.deliver_now


    redirect_to approval_path params[:approval_id]
  end
end
