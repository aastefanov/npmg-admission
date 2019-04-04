class School < ApplicationRecord
  validates_presence_of :region, :municipality, :city, :name
end