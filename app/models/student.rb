class Student < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :exams

  validates_presence_of :first_name, :middle_name, :last_name, :exams

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def active?
    super and self.is_active?
  end
end
