class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    comment = Comment.new comment_params
    comment.user = current_user

    @student = Student.find(comment_params[:student_id])


    if comment.valid?
      comment.save
      flash[:success] = "Успешно добавен коментар"

      if @student.user != current_user
        StudentMailer.with(user: @student.user, student: @student, approver: current_user).registration_commented.deliver_later
      end
    else
      flash[:error] = comment.errors.full_messages.to_sentence
    end
    redirect_back fallback_location: edit_student_path(comment.student_id)
    # redirect_to approval_path params[:id]
  end

  def comment_params
    params.require(:comment).permit(:student_id, :content)
  end
end
