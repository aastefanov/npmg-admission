class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :set_paper_trail_whodunnit
end
