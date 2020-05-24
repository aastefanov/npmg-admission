class Student < ApplicationRecord
  has_paper_trail

  belongs_to :school
  belongs_to :user

  has_many :student_exams
  has_many :exams, :through => :student_exams

  belongs_to :approver, class_name: 'User', required: false
  has_many :comments

  # has_one_attached :declaration

  validates_presence_of :first_name, :last_name, :school, :exams

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
    approved_at?
  end

  def is_declined?
    declined_at?
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

  def approver_status
    if approver_id?
      status
      # Approver has to check
    elsif !new_comments.present? or !last_approver_comment.present?
      :unapproved
      # Approver waits for parent
    elsif !last_parent_comment.present? or last_approver_comment > last_parent_comment
      :waiting
      # Parent corrected the approver
    elsif last_parent_comment > last_approver_comment
      :unapproved
    else
      nil
    end
  end

  def parent_status
    if approver_id?
      status
      # Parent waits for approver
    elsif !new_comments.present? or !last_approver_comment
      :unapproved
      # Approver demands a change
    elsif !last_parent_comment.present? or last_approver_comment > last_parent_comment
      :waiting
      # Parent corrected the approver
    elsif last_parent_comment > last_approver_comment
      :unapproved
    else
      nil
    end
  end

  def new_comments
    comments.where('created_at > ?', updated_at)
  end

  # after last update
  def last_parent_comment
    comments.where('user_id = ? AND created_at > ?', user_id, updated_at).maximum(:created_at)
  end

  # after last update
  def last_approver_comment
    comments.where('user_id != ? AND created_at > ?', user_id, updated_at).maximum(:created_at)
  end
end
