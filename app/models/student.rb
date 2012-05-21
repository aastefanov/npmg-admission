# encoding: uTF-8

class Student < ActiveRecord::Base
  has_and_belongs_to_many :grades, :join_table => :students_grades
  has_many :assessments, :dependent => :destroy
  belongs_to :user, :foreign_key => :registered_by
  has_paper_trail

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
  before_validation :validate_unique_exams

  def validate_unique_exams
    exams = []
    assessments.each do |e|
      exams << e.exam_id unless e.destroy?
    end
    set = Set.new exams
    if set.length != exams.length
      errors[:assessments] << "Не може да добавите повече от един запис, в който да сте упоменали един и същ изпит."
    end
  end

  def full_name
    first_name + " " + middle_name + " " + last_name
  end
end
