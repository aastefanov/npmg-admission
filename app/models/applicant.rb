# encoding: UTF-8

class Applicant < ActiveRecord::Base
  has_many :reviews
  has_many :assets
  has_paper_trail

  attr_accessible :egn, :email, :first_name, :last_name, :middle_name, :phone

  validates_presence_of :first_name, :middle_name, :last_name, :assets
  validates_associated :assets

  after_validation :validate_egn

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
    unless self.is_valid_egn(egn)
      errors[:egn] << "ЕГН не е валидно!"
    end
  end

  def self.is_valid_egn(egn)
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
