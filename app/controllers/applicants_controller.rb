# encoding: UTF-8

class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end

  def create
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
      @applicant = Applicant.includes(:assets, :reviews, :enrollment_assessments).find(current_applicant.id)
    else
      redirect_to new_applicant_session_path
    end
  end

  def update
    if params[:_continue]
      redirect_to root_path 
      return
    end

    @applicant = Applicant.find(params[:id])

    if @applicant.update_attributes(params[:applicant])
      flash[:notice] = "Успешно обновихте вашата кандидатура."
      redirect_to root_path
    else
      flash[:error] = "Възникна грешка при валидацията!"
      render :action => :edit
    end
  end

  def update_competitions_select
    competitions = Competition.where(:exam_id => params[:exam_id]) unless params[:exam_id].blank?
    render :partial => "competitions", :locals => { :competitions => competitions }
  end
end
