# encoding: UTF-8

class ApplicantsController < ApplicationController
  def new
    return if check_closed_register

    @applicant = Applicant.new
  end

  def certificate
    if current_applicant
      @print = true
      @object = current_applicant.student
      render :template => 'rails_admin/main/assessment_certificate'
    else
      redirect_to new_applicant_session_path
    end
  end

  def create
    return if check_closed_register

    if params[:_continue]
      redirect_to root_path 
      return
    end

    @applicant = Applicant.new(params[:applicant])
    if @applicant.save
      flash[:notice] = "Успешно направихте вашата кандидатура. Очаквайте нейното удобрение."
      redirect_to root_path
    else
      flash[:error] = "Възникна грешка при валидацията!"
      render :action => 'new'
    end
  end

  def edit
    if current_applicant
      if current_applicant.student_id
        flash[:error] = "Промяната на данни е затворена! Вие вече имате входящ номер."
        redirect_to root_path
        return
      end
      @applicant = Applicant.includes(:assets, :reviews, :enrollment_assessments).find(current_applicant.id)
    else
      redirect_to new_applicant_session_path
    end
  end

  def update
    if current_applicant
      if current_applicant.student_id
        flash[:error] = "Промяната на данни е затворена! Вие вече имате входящ номер."
        redirect_to root_path
        return
      end

      if params[:_continue]
        redirect_to root_path 
        return
      end

      @applicant = current_applicant
      if @applicant.update_attributes(params[:applicant])
        flash[:notice] = "Успешно обновихте вашата кандидатура."
        redirect_to root_path
      else
        flash[:error] = "Възникна грешка при валидацията!"
        render :action => :edit
      end
    else
      redirect_to new_applicant_session_path
    end
  end

  def update_competitions_select
    competitions = Competition.where(:exam_id => params[:exam_id]) unless params[:exam_id].blank?
    render :partial => "competitions", :locals => { :competitions => competitions }
  end

  private

  def check_closed_register
    return false unless Configurable.applicants_closed
    flash[:error] = "Срокът за регистрация е изтекъл."
    redirect_to root_path
    return true
  end
end
