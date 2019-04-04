class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable

  has_many :students

  has_and_belongs_to_many :roles

  validates_presence_of :email, :phone, :first_name, :last_name

  validates :phone,
            phone: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  def is_parent?
    roles.size == 0
  end
end
