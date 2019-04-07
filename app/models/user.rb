##
# A registered user
#
# Should be a parent or a legal guardian to one or many students

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable

  has_many :students

  has_and_belongs_to_many :roles

  validates_presence_of :email, :phone, :first_name, :last_name

  validates :phone,
            phone: true

  ##
  # Returns the full name of the user
  #
  # @return [String] The full name
  def full_name
    "#{first_name} #{last_name}"
  end

  ##
  # Returns if the user has a role
  #
  # @param role_sym [Symbol] The role name
  # @return [Boolean] Whether the user is in the role
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  ##
  # Returns if the user is a parent
  #
  # @return [Boolean] Whether the user is a parent
  def is_parent?
    roles.size == 0
  end
end
