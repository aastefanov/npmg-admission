class Student < ApplicationRecord
  has_paper_trail

  belongs_to :school
  belongs_to :user

  has_many :student_exams
  has_many :exams, :through => :student_exams

  belongs_to :approver, class_name: 'User', required: false
  has_many :comments

  # has_one_attached :declaration

  validates_presence_of :first_name, :last_name, :school

  # validates :declaration, :attached => true,
  #           :content_type => {:in => %w(image/png image/jpg image/jpeg),
  #                             :message => 'трябва да бъде във формат png, jpg или jpeg'},
  #           :size => {:less_than => 4.megabytes, message: 'трябва да бъде до 4 мегабайта'}

  validates :first_name, :middle_name, :last_name,
            :format => {with: /\A[\p{Cyrillic} \-.]+\z/u, message: "трябва да бъде на кирилица"}

  has_many :exam_results

  delegate :region, :city, :to => :school, :allow_nil => true


  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def is_approved?
    !approved_at.nil?
  end

  def is_declined?
    !declined_at.nil?
  end

  def status
    if is_approved?
      :approved
    elsif is_declined?
      :declined
    else
      :unapproved
    end
  end
end
