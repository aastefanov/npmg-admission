##
# Represents a school
#
# Used for statistics and lists

class School < ApplicationRecord
  belongs_to :city
  validates_presence_of :city, :name

  has_many :students

  ##
  # Returns the region of the school
  #
  # @return [Region] The region
  def region
    city.region
  end

  ##
  # Returns the region ID of the school
  #
  # @return [Integer] The region ID
  def region_id
    city.region_id
  end
end