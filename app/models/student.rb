class Student < ActiveRecord::Base
  has_and_belongs_to_many :grades, :join_table => :students_grades
  has_many :assessments
  belongs_to :user, :foreign_key => :registered_by
  
  before_validation lambda { self.registered_by = RailsAdmin.current_user_method }
  
  validates_presence_of :first_name, :middle_name, :last_name, :address, :registered_by
  
  validates :email,   
            :presence => true,   
            :uniqueness => true,   
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }  
            
  validates :egn,
            :presence => true,
            :uniqueness => true,
            :numericality => true
            
  validates :ref_number,
            :presence => true,
            :uniqueness => true,
            :numericality => true
            
  validates :phone,
            :presence => true,
            :numericality => true
end
