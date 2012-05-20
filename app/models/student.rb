class Student < ActiveRecord::Base
  has_and_belongs_to_many :grades, :join_table => :students_grades
  has_many :assessments, :dependent => :destroy
  belongs_to :user, :foreign_key => :registered_by

  accepts_nested_attributes_for :assessments, :allow_destroy => true
  # attr_accessible :assessments_attributes
  
  validates_presence_of :first_name, :middle_name, :last_name, :registered_by, :grades, :assessments

  validates :egn,
            :presence => true,
            :uniqueness => true,
            :numericality => true,
            :length => {:within => 10..10}
            
  validates :phone,
            :presence => true,
            :numericality => true

  validates_associated :assessments

  def full_name
    first_name + " " + middle_name + " " + last_name
  end
end
