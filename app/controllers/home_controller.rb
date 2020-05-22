class HomeController < ApplicationController
  def index
    @posts = Post.select(:name, :content).order(:created_at => :desc).all
    @page = Page.find_by_name('index')
  end

  def page
    @page = Page.find_by_name(params[:name])
    render :status => :not_found, :file => "#{Rails.root}/public/404", :layout => false if @page.nil?
  end
end
