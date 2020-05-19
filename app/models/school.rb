class School < ApplicationRecord
  belongs_to :city
  delegate :region, :to => :city

  validates_presence_of :admin_id, :name, :city

  has_many :students
end
