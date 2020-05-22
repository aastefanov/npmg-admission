class Page < ApplicationRecord
  has_paper_trail

  validates_presence_of :name, :content
end
