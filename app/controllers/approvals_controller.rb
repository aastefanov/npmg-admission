class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :non_parent
  before_action :set_paper_trail_whodunnit


  def non_parent
    if current_user.is_parent?
      raise CanCan::AccessDenied.new
    end
  end

  def index
    @students = Student.where(:declined_at => nil, :approved_at => nil)
  end

  def show
    @student = Student.find(params[:id])
    @same_egn = Student.joins(:student_egn).where(student_egns: {egn: @student.egn}).where.not(id: params[:id])
  end

  def approve
    @student = Student.find(params[:id])

    if @student.is_approved? or @student.is_declined?
      flash[:error] = "Вече одобрен или отхвърлен - " + @student.full_name
      redirect_back fallback_location: approvals_path
      return
    end

    @student.approved_at = DateTime.now
    @student.approver_id = current_user.id

    @student.ref_num = (Student.maximum("ref_num").to_i || 0) + 1

    if @student.valid?
      @student.save
      StudentMailer.with(user: @student.user, student: @student, approver: current_user).registration_approved.deliver_later
      flash[:success] = "Успешно одобрихте " + @student.full_name
    else
      flash[:error] = @student.errors.full_messages.to_sentence
    end
    redirect_to approvals_path
  end

  def reject
    @student = Student.find(params[:id])

    if @student.is_approved? or @student.is_declined?
      flash[:error] = "Вече одобрен или отхвърлен - " + @student.full_name
      redirect_back fallback_location: approvals_path
      return
    end
    @student.declined_at = DateTime.now
    @student.approver_id = current_user.id

    if @student.valid?
      @student.save
      StudentMailer.with(user: @student.user, student: @student, approver: current_user).registration_declined.deliver_later

      flash[:success] = "Успешно отхвърлихте " + @student.full_name
    else
      flash[:error] = @student.errors.full_messages.to_sentence
    end
    redirect_to approvals_path
  end
end
