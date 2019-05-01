class StudentsController < ApplicationController
  before_action :authenticate_user!

  ##
  # Shows all students of the logged in user
  def index
    @students = Student.where user_id: current_user.id
  end

  ##
  # Mass Assignment protection for the student model
  # @param :student [Student] Request model
  # @returns [Parameters] Parameters specification
  def student_params
    params.require(:student).permit(:first_name, :last_name, :middle_name, :declaration, :school, :exams => [])
  end

  ##
  # Creates a new student
  # @param :student [Student] The student to be created
  # @return [void]
  def create

    attributes = student_params.clone
    attributes[:school] = School.find_by_id(student_params[:school])
    attributes[:exams] = Exam.find((student_params[:exams] || []).reject(&:blank?))
    attributes[:user] = current_user
    attributes[:exam_ids] = (student_params[:exams] || []).compact
    @student = Student.new attributes

    request = ApprovalRequest.new :student => @student

    if request.save
      redirect_to :action => :index
    else
      flash[:error] = "Неуспешна регистрация.\n" + request.errors.full_messages.to_sentence
      render :new
    end
  end

  ##
  # Opens the :new page with an empty student
  # @return [void]
  def new
    @student = Student.new
  end
end