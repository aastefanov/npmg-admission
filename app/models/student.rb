class Student < ActiveRecord::Base
  has_and_belongs_to_many :grades, :join_table => :students_grades
  has_many :assessments, :dependent => :destroy
  belongs_to :user, :foreign_key => :registered_by
  
  validates_presence_of :first_name, :middle_name, :last_name, :registered_by

  after_update :save_assessments

  validates :egn,
            :presence => true,
            :uniqueness => true,
            :numericality => true,
            :length => {:within => 10..10}
            
  validates :phone,
            :presence => true,
            :numericality => true

  validates_associated :assessments

  def assessments_attributes=(assessments_attributes)
    assessments_attributes.each do |attributes|
      if attributes[:id].blank?
        assessments.build(attributes)
      else
        assessment = assessments.detect { |t| t.id == attributes[:id].to_i }
        assessment.attributes = attributes
      end
    end
  end

  def save_assessments
    assessments.each do |t|
      if t.should_destroy?
        t.destroy
      else
        t.save(false)
      end
    end
  end

  def full_name
    first_name + " " + middle_name + " " + last_name
  end
end
