# encoding: UTF-8

class StudentsController < ApplicationController
  def results
    @screen = true
    @student = Student.where(:id => params[:id]).where(:egn => params[:egn]).includes(:assessments).first

    unless @student
      flash[:error] = "Не съществува ученик с данните, въведени от вас! Моля опитайте отново или се свържете с нас."
      redirect_to root_url
      return
    end

    @assessments = Assessment.joins(:exam).where(:student_id => @student.id)
  end
end
