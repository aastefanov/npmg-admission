class StudentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
    # redirect_to edit_student_path(params[:id])
  end

  ##
  # Shows all students of the logged in user
  def index
    @registration_closed = check_closed_register?
    @students = Student.where user_id: current_user.id
  end

  def edit
  end

  def update
    attributes = student_params.clone

    attributes[:exam_ids] = (student_params[:exam_ids] || []).reject(&:blank?).compact

    @student.update attributes

    if @student.valid?
      flash[:success] = "Успешно променихте " + @student.full_name
      redirect_to students_path
    else
      flash[:error] = @student.errors.full_messages.to_sentence
      render :edit
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
    attributes[:user] = current_user
    attributes[:exam_ids] = (student_params[:exam_ids] || []).reject(&:blank?).compact

    @student = Student.new attributes

    @student.save
    if @student.valid?
      flash[:success] = "Успешно създадохте " + @student.full_name
      redirect_to students_path
    else
      flash[:error] = @student.errors.full_messages.to_sentence
      render :new
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
    params.require(:student).permit(:first_name, :last_name, :middle_name, :school_id, :personal_data, :student_egn_attributes => [:egn], :exam_ids => [])
  end
end
