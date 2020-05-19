class StudentsController < ApplicationController
  before_action :authenticate_user!

  def show
    check_student_parent(@student, current_user)
    redirect_to edit_student_path(params[:id])
  end

  ##
  # Shows all students of the logged in user
  def index
    @registration_closed = check_closed_register?

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

    unless student_params[:exam_ids].present? and student_params[:exam_ids].any?(&:present?)
      flash[:error] = "Неуспешна промяна.\n" +
          "Задължително е да изберете модули"
      render :edit
      return
    end

    exams = (student_params[:exam_ids] || []).reject(&:blank?).compact
    attributes = attributes.except :exams, :exam_ids

    # if @student.update(attributes)
    #   redirect_to :action => :index
    # else
    #   flash[:error] = "Неуспешна промяна.\n" + @student.errors.full_messages.to_sentence
    #   render :edit
    # end

    ActiveRecord::Base.transaction do
      StudentExam.where(student_id: @student.id).delete_all
      student_exams = []
      exams.each do |e|
        student_exams << StudentExam.new(exam_id: e, student_id: @student.id)
      end
      StudentExam.import! student_exams
      @student.save!
      redirect_to :action => :index
    end
  rescue ActiveRecord::RecordInvalid => exception
    flash[:error] = "Неуспешна промяна.\n" +
        @student.errors.full_messages.to_sentence + ".\n" +
        student_exams.map(&:full_messages.to_sentence).join(".\n") + "."
    # request.student.errors.full_messages.to_sentence + "."
    #    raise ActiveRecord::Rollback
    render :edit
  end


  ##
  # Creates a new student
  # @param :student [Student] The student to be created
  # @return [void]
  def create
    redirect_closed_register
    return if check_closed_register?

    attributes = student_params.clone
    attributes[:school] = School.find(student_params[:school_id])
    attributes[:user] = current_user
    attributes[:exam_ids] = (student_params[:exam_ids] || []).reject(&:blank?).compact

    student_attributes = attributes.except :exams, :exam_ids

    @student = Student.new student_attributes

    unless student_params[:exam_ids].present? and student_params[:exam_ids].any?(&:present?)
      flash[:error] = "Неуспешна промяна.\n" +
          "Задължително е да изберете модули"
      render :new
      return
    end


    ActiveRecord::Base.transaction do
      @student.save!
      student_exams = []
      attributes[:exam_ids].each do |e|
        student_exams << StudentExam.new(exam_id: e, student_id: @student.id)
      end
      StudentExam.import! student_exams
      redirect_to :action => :index
    end
  rescue ActiveRecord::RecordInvalid => exception
    flash[:error] = "Неуспешна регистрация.\n" +
        @student.errors.full_messages.to_sentence + ".\n" +
        student_exams.map(&:full_messages.to_sentence).join(".\n") + "."
    # request.student.errors.full_messages.to_sentence + "."
    #    raise ActiveRecord::Rollback
    render :new
  end

  ##
  # Opens the :new page with an empty student
  # @return [void]
  def new
    redirect_closed_register
    return if check_closed_register?
    @student = Student.new
  end

  private

  def check_student_not_finalized(student)
    if student.status != :unapproved
      # if student.is_approved? || student.is_rejected?
      flash[:error] = "Нямате достъп до тази страница"
      redirect_back fallback_location: root_path
    end
  end

  def check_student_parent(student, parent)
    if student.user != parent
      flash[:error] = "Нямате достъп до тази страница"
    end
  end


  def check_closed_register?
    AppSettings.find_by_key('registration_closed').value != 'false'
  end

  def redirect_closed_register
    if check_closed_register?
      flash[:error] = "Регистрацията е затворена"
      redirect_back fallback_location: root_path
    end
  end

  ##
  # Mass Assignment protection for the student model
  # @param :student [Student] Request model
  # @returns [Parameters] Parameters specification
  def student_params
    params.require(:student).permit(:first_name, :last_name, :middle_name, :declaration, :school_id, :exam_ids => [])
  end
end
