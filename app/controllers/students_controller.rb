class StudentsController < ApplicationController
  before_action :authenticate_user!

  def show
    check_student_parent(@student, current_user)
    redirect_to edit_student_path(params[:id])
  end

  ##
  # Shows all students of the logged in user
  def index
    @students = Student.where user_id: current_user.id
  end

  def edit
    @student = Student.find params[:id]
    check_student_parent(@student, current_user)
    check_student_not_finalized(@student)

  end

  def update
    @student = Student.find params[:id]
    check_student_parent(@student, current_user)
    check_student_not_finalized(@student)

    attributes = student_params.clone
    attributes[:school] = School.find(student_params[:school_id])

    if student_params[:exam_ids].present? and student_params[:exam_ids].any?(&:present?)
      attributes[:exam_ids] = (student_params[:exam_ids] || []).reject(&:blank?).compact
      attributes[:exams] = Exam.find(attributes[:exam_ids])
    else
      attributes = attributes.except :exams, :exam_ids
    end

    if @student.update(attributes)
      redirect_to :action => :index
    else
      flash[:error] = "Неуспешна промяна.\n" + @student.errors.full_messages.to_sentence
      render :edit
    end
  end


  ##
  # Creates a new student
  # @param :student [Student] The student to be created
  # @return [void]
  def create
    return if check_closed_register
    attributes = student_params.clone
    attributes[:school] = School.find(student_params[:school_id])
    attributes[:user] = current_user
    attributes[:exam_ids] = (student_params[:exam_ids] || []).reject(&:blank?).compact
    attributes[:exams] = Exam.find(attributes[:exam_ids])

    @student = Student.new attributes

    request = ApprovalRequest.new :student => @student

    if request.save
      redirect_to :action => :index
    else
      flash[:error] = "Неуспешна регистрация.\n" +
          request.student.errors.full_messages.to_sentence + "."
      render :new
    end
  end

  ##
  # Opens the :new page with an empty student
  # @return [void]
  def new
    return if check_closed_register
    @student = Student.new
  end

  private

  def check_student_not_finalized(student)
    if student.is_approved? || student.is_rejected?
      flash[:error] = "Нямате достъп до тази страница"
      redirect_back fallback_location: root_path
    end
  end

  def check_student_parent(student, parent)
    if student.user != parent
      flash[:error] = "Нямате достъп до тази страница"
    end
  end

  def check_closed_register
    if Rails.configuration.configurable['registration_closed']
      flash[:error] = "Регистрацията е затворена"
      redirect_back fallback_location: root_path
      return true
    end
  end
  ##
  # Mass Assignment protection for the student model
  # @param :student [Student] Request model
  # @returns [Parameters] Parameters specification
  def student_params
    params.require(:student).permit(:first_name, :last_name, :middle_name, :declaration, :school_id, :class_name, :exam_ids => [])
  end
end
