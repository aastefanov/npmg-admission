class Asset < ActiveRecord::Base
  belongs_to :applicant
  has_attached_file :file

  attr_accessor :delete_file
  before_validation { self.file.clear if self.delete_file == '1' }
end
