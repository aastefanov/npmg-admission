##
# Represents a student application
#

class Student < ApplicationRecord
  alias_attribute :parent, :user
  alias_attribute :request, :approval_request
  # meta: {
  #     is_approved: :is_approved,
  #     review: :review
  # }

  has_one :approval_request
  belongs_to :user
  belongs_to :school

  has_one :city, :through => :school
  has_one :region, :through => :city

  has_and_belongs_to_many :exams

  has_one_attached :declaration

  validates_presence_of :first_name, :middle_name, :last_name, :declaration, :school, :exams, :class_name

  validates :first_name, :middle_name, :last_name,
            :format => {with: /\p{Cyrillic}+/u, message: "трябва да бъде на кирилица"}

  validates :declaration, :attached => true,
            :content_type => {:in => %w(image/png image/jpg image/jpeg),
                              :message => 'трябва да бъде във формат png, jpg или jpeg'},
            :size => {:less_than => 4.megabytes, message: 'трябва да бъде до 4 мегабайта'}

  def is_approved?
    approval_request&.is_approved?
  end

  def is_rejected?
    approval_request&.is_rejected?
  end

  def is_commented?
    return false if approval_request&.comments.blank?
    approval_request&.comments&.max_by(&:created_at).created_at > updated_at
  end

  def is_unapproved?
    !is_approved? && !is_rejected? && !is_commented?
  end

  def status
    return :approved if is_approved?
    return :rejected if is_rejected?
    return :commented if is_commented?
    return :unapproved
  end

  ##
  # Returns the full name of the user
  #
  # @return [String] The full name
  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end
end
