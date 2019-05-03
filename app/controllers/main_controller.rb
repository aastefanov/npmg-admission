##
# The default route for the application
class MainController < ApplicationController
  ##
  # Shows the layout for the homepage
  def index
    @posts = Post.all
  end
end
