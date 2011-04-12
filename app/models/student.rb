class Student < ActiveRecord::Base
  has_and_belongs_to_many :grades, :join_table => :students_grades
  has_many :assessments
  belongs_to :user, :foreign_key => :registered_by
  
  before_validation lambda { self.registered_by = RailsAdmin.current_user_method }
  
  validates_presence_of :first_name, :middle_name, :last_name, :registered_by

  validates :egn,
            :presence => true,
            :uniqueness => true,
            :numericality => true,
            :length => {:within => 10..10}
            
  validates :phone,
            :presence => true,
            :numericality => true

  def full_name
    first_name + " " + middle_name + " " + last_name
  end
end
