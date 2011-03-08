class Student < ActiveRecord::Base
  has_and_belongs_to_many :grades
  has_many :assessments
  belongs_to :user, :foreign_key => :registered_by
  
  validates_presence_of :first_name, :middle_name, :last_name, :egn, :ref_number, :phone, :email, :address, :registered_by
end
