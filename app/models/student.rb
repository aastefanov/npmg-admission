##
# Represents a student application
#

class Student < ApplicationRecord
  has_paper_trail only: [:first_name, :last_name, :middle_name, :school, :declaration],
                  ignore: [:is_approved, :review]
  # meta: {
  #     is_approved: :is_approved,
  #     review: :review
  # }

  belongs_to :user
  belongs_to :school

  has_one :city, through: :school
  has_one :region, through: :city

  has_and_belongs_to_many :exams

  has_one_attached :declaration

  validates_presence_of :first_name, :middle_name, :last_name, :declaration, :school, :exams

  ##
  # Returns the full name of the user
  #
  # @return [String] The full name
  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end
end
