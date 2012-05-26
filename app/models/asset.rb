class Asset < ActiveRecord::Base
  belongs_to :applicant
  has_attached_file :file

  attr_accessor :delete_file, :_destroy
  before_validation { self.file.clear if self.delete_file == '1' || _destroy.to_i == 1 }

  validates_presence_of :description
  validates_attachment :file, :presence => true,
    :content_type => { :content_type => /image/ },
    :size => { :in => 0..5.megabytes }
end
