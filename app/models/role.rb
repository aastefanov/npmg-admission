##
# Defines a user role
#
# Required for authorization

class Role < ApplicationRecord
  has_and_belongs_to_many :users
  validates_presence_of :name
end