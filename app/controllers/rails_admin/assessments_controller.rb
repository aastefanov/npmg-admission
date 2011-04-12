module RailsAdmin
  class AssessmentsController < RailsAdmin::ApplicationController

    def get_assessments
      @authorization_adapter.authorize(:index) if @authorization_adapter
      
      @assessments = Array.new
      @grade = Grade.find(params[:id])
      @grade.exams.each do |exam|
        @assessments << Assessment.build(exam)
      end
    end

  end
end
