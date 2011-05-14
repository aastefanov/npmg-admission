class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  
  has_many :students, :foreign_key => :registered_by
  
  validates_presence_of :first_name, :last_name, :email
  
  def full_name
    (first_name || "") + " " + (last_name || "")
  end

  def active?
    super and self.is_active?
  end
end
