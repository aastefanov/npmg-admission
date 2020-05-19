class HomeController < ApplicationController
  def index
    @posts = Post.select(:title, :content).order(:created_at => :desc).all
  end

  def registered
  end

  def confirmed
  end
end
