##
# Base DB Entity class

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end