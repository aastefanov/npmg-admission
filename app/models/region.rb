class Region < ApplicationRecord
  has_many :cities
  has_many :schools, :through => :cities

  validates_presence_of :name
end
