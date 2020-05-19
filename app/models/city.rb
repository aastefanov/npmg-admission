class City < ApplicationRecord
  belongs_to :region
  has_many :schools

  validates_presence_of :name, :region
end
