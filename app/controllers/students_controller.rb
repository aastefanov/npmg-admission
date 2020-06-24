class StudentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource :only => [:edit, :placements]

  def show
    @expect_belejka = Page.find_by_name(:expect_belejka).content
    @placements_ready = check_placements_ready?
    # redirect_to edit_student_path(params[:id])
  end

  def placements
    redirect_placements_ready
    @student = Student.find(params[:id])
    raise CanCan::AccessDenied unless can? :read, @student

    @slujbel_decline = Page.find_by_name(:slujbel_decline).content
    @slujbel_footer = Page.find_by_name(:slujbel_footer).content


    respond_to do |format|
      format.pdf do
        render pdf: @student.ref_num.to_s,
               template: 'students/placements.html.erb',
               print_media_type: true
      end
      format.html do
        render :layout => false
      end
    end
  end

  ##
  # Shows all students of the logged in user
  def index
    @registration_closed = check_closed_register?
    @placements_ready = check_placements_ready?
    @students = Student.where user_id: current_user.id
  end

  def edit
    redirect_to :action => :show, id: params[:id] unless can? :edit, @student

    @personaldata_pre = Page.find_by_name(:personaldata_pre).content
    @personaldata_decline = Page.find_by_name(:personaldata_decline).content
  end

  def update
    @personaldata_pre = Page.find_by_name(:personaldata_pre).content
    @personaldata_decline = Page.find_by_name(:personaldata_decline).content

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
    @personaldata_pre = Page.find_by_name(:personaldata_pre).content
    @personaldata_decline = Page.find_by_name(:personaldata_decline).content

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
    @personaldata_pre = Page.find_by_name(:personaldata_pre).content
    @personaldata_decline = Page.find_by_name(:personaldata_decline).content
    @student = Student.new
  end

  private

  def check_closed_register?
    AppSettings.find_by_key('registration_closed').value != 'false'
  end

  def check_placements_ready?
    AppSettings.find_by_key('placements').value == 'true'
  end

  def redirect_placements_ready
    unless check_placements_ready?
      flash[:error] = "Няма разпределения"
      redirect_back fallback_location: root_path
    end
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
