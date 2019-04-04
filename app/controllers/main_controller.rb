class MainController < ApplicationController
  def index
    @student = Student.new
    @screen = true
  end
end
