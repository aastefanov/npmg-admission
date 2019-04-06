##
# Represents a school
#
# Used for statistics and lists

class School < ApplicationRecord
  belongs_to :city
  validates_presence_of :city, :name

  def region
    city.region
  end

  def region_id
    city.region_id
  end
end