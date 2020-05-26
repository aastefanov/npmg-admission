class StudentEgn < ApplicationRecord
  belongs_to :student

  validates_presence_of :student, :egn

  validates :egn, length: {is: 10}, numericality: true
  validate :egn_or_lnch, on: [:create, :update]

  def egn_or_lnch
    return unless errors.blank?
    errors.add(:egn, "Невалидно ЕГН/ЛНЧ") unless Egn.validate(egn) or valid_lnch?
  end

  private

  def valid_lnch?
    res = lnch_checksum(egn[0, 9])
    res == egn[10].to_i
  end

  private

  WEIGHTS = [21, 19, 17, 13, 11, 9, 7, 3, 1]

  def lnch_checksum(lnch)
    sum = lnch.chars.map(&:to_i).zip(WEIGHTS).map { |n| n.reduce(:*) }.reduce(:+)
    sum % 10
  end
end
