# encoding: UTF-8

class Applicant < ActiveRecord::Base
  has_many :reviews
  has_many :assets
  has_many :enrollment_assessments
  has_paper_trail

  devise :database_authenticatable

  accepts_nested_attributes_for :enrollment_assessments, :allow_destroy => true
  accepts_nested_attributes_for :assets, :allow_destroy => true
  accepts_nested_attributes_for :reviews, :allow_destroy => true

  attr_accessible :egn, :password, :password_confirmation,:email, :first_name, :last_name, :middle_name, :phone, :assets_attributes, :enrollment_assessments_attributes

  validates_presence_of :first_name, :middle_name, :last_name, :assets, :enrollment_assessments
  validates_associated :assets, :enrollment_assessments

  after_validation :validate_egn, :validate_unique_exams

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

  def validate_egn
    unless is_valid_egn(egn)
      errors[:egn] << "ЕГН не е валидно!"
    end
  end

  def validate_unique_exams
    exams = []
    enrollment_assessments.each do |e|
      exams << e.exam_id unless e._destroy.to_i == 1
    end
    set = Set.new exams
    if set.length != exams.length
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
end
