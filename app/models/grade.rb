class Grade < ApplicationRecord
  belongs_to :exam
  # TODO: Check if constraint is valid
  belongs_to :student, :foreign_key => :ref_num, :primary_key => :ref_num
end
