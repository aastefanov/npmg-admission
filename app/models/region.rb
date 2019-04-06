##
# Represents a region
#
# Used for school statistics and lists

class Region < ApplicationRecord
  has_many :cities
  has_many :schools, through: :cities

  validates_presence_of :name, :short_name
end