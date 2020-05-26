class StudentsMailer < ApplicationMailer
  def registration_commented
    @user = params[:user]
    @student = params[:student]

    mail to: @user.email, subject: "Добавен коментар към регистрация"
  end

  def registration_approved
    @user = params[:user]
    @student = params[:student]

    mail to: @user.email, subject: "Одобрена регистрация"

  end

  def registration_declined
    @user = params[:user]
    @student = params[:student]

    mail to: @user.email, subject: "Отхвърлена регистрация"
  end
end
