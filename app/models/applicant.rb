# encoding: UTF-8

class Applicant < ActiveRecord::Base
  has_many :reviews
  has_many :assets
  has_many :enrollment_assessments
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

  scope :unapproved, where("`applicants`.`approved` < `applicants`.`version_n` AND `applicants`.`approved` != 0")
  scope :approved, where("`applicants`.`approved` = `applicants`.`version_n`")
  scope :dissapproved, where("`applicants`.`approved` = 0")
  scope :not_viewed, where("`applicants`.`last_viewed` IS NULL OR `applicants`.`last_viewed` < ?", DateTime.now - 1.hour)

  attr_accessor :_dissapprove, :_approve

  def versionizer
    version_n  ||= 2
    approved ||= 1
    if _approve
      approved = version_n
    elsif _dissapprove
      approved = 0
    else
      version_n += 1
      approved = 1 if approved == 0
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
    strings = ['Отхвърлен', 'Изчакване', 'Удобрен']
    return strings[status]
  end

  def user_edits
    num = 0
    versions.each { |v| num += 1 if v.whodunnit.nil? }
    return num
  end
end
