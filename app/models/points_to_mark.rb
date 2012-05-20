class PointsToMark < ActiveRecord::Base
  belongs_to :competition

  validates :mark,
    :inclusion => {:in => 2.0..6.0},
    :allow_blank => false,
    :allow_nil => false

  validates :to_range,
            :presence => true,
            :numericality => true

  validates_presence_of :competition_id

  attr_accessible :mark, :to_range, :competition_id

  def self.get_mark(points, competition)
    result = PointsToMark.where(:competition_id => competition).where('to_range >= ?', points).order(:to_range).first
    result.nil? ? 0.0 : result.mark
  end
end
