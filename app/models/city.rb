##
# Represents a city
#
# Used for school statistics and lists

class City < ApplicationRecord
  belongs_to :region
  has_many :schools

  validates_presence_of :region, :name
end