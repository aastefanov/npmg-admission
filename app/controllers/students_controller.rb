class StudentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

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
    # @student = Student.find params[:id]
    # check_student_parent(@student, current_user)
    # check_student_not_finalized(@student)
  end

  def update
    # @student = Student.find params[:id]
    # check_student_parent(@student, current_user)
    # check_student_not_finalized(@student)

    attributes = student_params.clone
    unless student_params[:school_id].present?
      flash[:error] = "Задължително е да изберете училище"
      render :edit
      return
    end
    attributes[:school] = School.find(student_params[:school_id])

    unless student_params[:exam_ids].present? and student_params[:exam_ids].any?(&:present?)
      flash[:error] = "Задължително е да изберете модули"
      render :edit
      return
    end

    exams = (student_params[:exam_ids] || []).reject(&:blank?).compact
    attributes[:exam_ids] = (student_params[:exam_ids] || []).reject(&:blank?).compact
    student_attributes = attributes.except :exams, :exam_ids

    ActiveRecord::Base.transaction do
      @student.update student_attributes
      @student.exams.delete_all
      student_exams = []
      attributes[:exam_ids].each do |e|
        student_exams << StudentExam.new(exam_id: e, student_id: @student.id)
      end
      import_result = StudentExam.import student_exams

      if @student.valid? and import_result.failed_instances.empty?
        flash[:success] = "Успешно променихте " + @student.full_name
        redirect_to students_path
        # redirect_to :action => :index
      else
        error = ""
        # error = "Неуспешна промяна.\n"
        if @student.invalid?
          error += @student.errors.full_messages.to_sentence + ".\n"
        elsif !import_result.failed_instances.empty?
          error += import_result.failed_instances.map(&:errors.full_messages.to_sentence).join(".\n") + "."
        end
        flash[:error] = error

        render :edit
        raise ActiveRecord::Rollback
      end
    end
  end


  ##
  # Creates a new student
  # @param :student [Student] The student to be created
  # @return [void]
  def create
    redirect_closed_register
    return if check_closed_register?

    attributes = student_params.clone
    unless student_params[:school_id].present?
      flash[:error] = "Задължително е да изберете училище"
      render :new
      return
    end
    attributes[:school] = School.find_by_id(student_params[:school_id])
    attributes[:user] = current_user
    attributes[:exam_ids] = (student_params[:exam_ids] || []).reject(&:blank?).compact

    student_attributes = attributes.except :exams, :exam_ids

    @student = Student.new student_attributes

    unless student_params[:exam_ids].present? and student_params[:exam_ids].any?(&:present?)
      flash[:error] = "Задължително е да изберете модули"
      render :new
      return
    end

    ActiveRecord::Base.transaction do
      @student.save
      student_exams = []
      attributes[:exam_ids].each do |e|
        student_exams << StudentExam.new(exam_id: e, student_id: @student.id)
      end
      import_result = StudentExam.import student_exams

      if @student.valid? and import_result.failed_instances.empty?
        flash[:success] = "Успешно създадохте " + @student.full_name
        redirect_to students_path
      else
        error = ""
        if !@student.valid?
          error += @student.errors.full_messages.to_sentence + ".\n"
        elsif !import_result.failed_instances.empty?
          error += import_result.failed_instances.map(&:errors.full_messages.to_sentence).join(".\n") + "."
        end
        flash[:error] = error

        render :new
        raise ActiveRecord::Rollback
      end
    end
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
    params.require(:student).permit(:first_name, :last_name, :middle_name, :school_id, :personal_data, :exam_ids => [])
  end
end
