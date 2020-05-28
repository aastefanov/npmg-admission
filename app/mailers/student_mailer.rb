class StudentMailer < ApplicationMailer
  def registration_commented
    @user = params[:user]
    @student = params[:student]
    @approver = params[:approver]

    mail to: @user.email, subject: "Добавен коментар към регистрация"
  end

  def registration_approved
    @user = params[:user]
    @student = params[:student]
    @approver = params[:approver]

    mail to: @user.email, subject: "Одобрена регистрация"

  end

  def registration_declined
    @user = params[:user]
    @student = params[:student]
    @approver = params[:approver]

    mail to: @user.email, subject: "Отхвърлена регистрация"
  end
end
