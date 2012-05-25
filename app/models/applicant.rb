# encoding: UTF-8

class Applicant < ActiveRecord::Base
  has_many :reviews
  has_many :assets
  has_many :enrollment_assessments
  belongs_to :student
  has_paper_trail

  devise :database_authenticatable, :validatable, :recoverable

  accepts_nested_attributes_for :enrollment_assessments, :allow_destroy => true
  accepts_nested_attributes_for :assets, :allow_destroy => true
  accepts_nested_attributes_for :reviews, :allow_destroy => true

  attr_accessible :egn, :password, :password_confirmation, :email, :first_name, :last_name, :middle_name, :phone, :last_viewed, :assets_attributes, :enrollment_assessments_attributes, :reviews_attributes

  validates_presence_of :first_name, :middle_name, :last_name, :assets, :enrollment_assessments
  validates_associated :assets, :enrollment_assessments

  validate :validate_egn, :validate_unique_exams

  validates :egn,
            :presence => true,
            :uniqueness => true,
            :numericality => true,
            :length => {:within => 10..10}
          
  validates :phone,
            :presence => true,
            :numericality => true

  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i },
            :uniqueness => true

  before_update :versionizer
  before_create :versionizer

  scope :unapproved, where("`applicants`.`approved` < `applicants`.`version_n` AND `applicants`.`approved` != 0")
  scope :approved, where("`applicants`.`approved` = `applicants`.`version_n`")
  scope :dissapproved, where("`applicants`.`approved` = 0")
  scope :not_viewed, where("`applicants`.`last_viewed` IS NULL OR `applicants`.`last_viewed` <= ?", DateTime.now - 1.hour)

  attr_accessor :_dissapprove, :_approve, :_no_view_date

  def versionizer
    self.version_n  ||= 2
    self.approved ||= 1
    if _approve
      self.approved = self.version_n
    elsif _dissapprove
      self.approved = 0
    else
      self.last_viewed = DateTime.now - 2.hour unless _no_view_date
      self.version_n += 1
      self.approved = 1 if self.approved == 0
    end
  end

  def validate_egn
    unless is_valid_egn(egn)
      errors[:egn] << "ЕГН не е валидно!"
    end
  end

  def validate_unique_exams
    exams = []
    enrollment_assessments.each do |e|
      exams << e.exam_id unless e.destroy?
    end
    set = Set.new exams
    unless set.length == exams.length
      errors[:enrollment_assessments] << "Не може да добавите повече от един запис, в който да сте упоменали един и същ изпит."
    end
  end

  def is_valid_egn(egn)
    s = egn.to_s
    t = [2,4,8,5,10,9,7,3,6]
    return false if s.length != 10 
    rr = 0
    9.times do |i|
      next if s[i].to_i == 0 
      rr = rr + (s[i].to_i * t[i])
    end

    chs = rr % 11
    chs = 0 if chs == 10
    return s[9].to_i == chs ? true : false
  end

  def full_name
    first_name + " " + middle_name + " " + last_name
  end

  def status
    if approved == 0
      return 0 
    elsif approved == version_n
      return 2
    else
      return 1
    end
  end

  def status_text
    strings = ['Отхвърлен', 'Изчакване', 'Одобрен']
    return strings[status]
  end

  def user_edits
    num = 0
    versions.each { |v| num += 1 if v.whodunnit.nil? }
    return num
  end

  def export_to_student
    return 0 if status != 2

    student = Student.new :first_name => first_name, :middle_name => middle_name, :last_name => last_name, :egn => egn, :phone => phone
    
    enrollment_assessments.each do |enrollment|
      assessment = Assessment.new :exam_id => enrollment.exam_id, :is_taking_exam => enrollment.is_taking_exam
      if enrollment.points
        mark = PointsToMark.get_mark(enrollment.points, enrollment.competition_id).to_f
        if (mark < 2.0 || mark > 6.0 || mark.nil?) && !enrollment.is_taking_exam?
          return 1
        else
          assessment.competition_mark = mark
        end
      end
      student.assessments << assessment
    end

    versions.reverse.each do |ver|
      if ver.whodunnit
        student.registered_by = ver.whodunnit.to_i
        break
      end
    end

    student.save!
    self.student_id = student.id
    self._approve = true
    self.save!
    return 2
  end
end
