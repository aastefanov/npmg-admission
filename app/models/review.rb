class Review < ActiveRecord::Base
  belongs_to :applicant
  attr_accessible :content, :applicant_id

  validates_presence_of :content, :applicant_id
end
