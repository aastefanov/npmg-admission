class Comment < ApplicationRecord
  belongs_to :student
  belongs_to :user

  validates_presence_of :content
end
