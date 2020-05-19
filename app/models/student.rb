class Student < ApplicationRecord
  has_paper_trail

  belongs_to :school
  belongs_to :user

  has_many :student_exams
  has_many :exams, :through => :student_exams

  has_one_attached :declaration

  validates_presence_of :first_name, :last_name, :declaration, :school

  validates :declaration, :attached => true,
            :content_type => {:in => %w(image/png image/jpg image/jpeg),
                              :message => 'трябва да бъде във формат png, jpg или jpeg'},
            :size => {:less_than => 4.megabytes, message: 'трябва да бъде до 4 мегабайта'}

  validates :first_name, :middle_name, :last_name,
            :format => {with: /\p{Cyrillic}*/u, message: "трябва да бъде на кирилица"}

  has_many :exam_results, foreign_key: :ref_num, primary_key: :ref_num

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
