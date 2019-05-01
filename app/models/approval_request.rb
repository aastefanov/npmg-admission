class ApprovalRequest < ApplicationRecord
  alias_attribute :comments, :approval_comments
  alias_attribute :comment_ids, :approval_comment_ids

  alias_attribute :parent, :user
  alias_attribute :parent_id, :user_id

  has_many :approval_comments
  belongs_to :student

  belongs_to :respond_user, :class_name => 'User', :foreign_key => :respond_user_id

  delegate :user, :to => :student

  validates_presence_of :student
  validates_associated :student

  def is_approved?
    !approved_at.nil?
  end

  def is_rejected?
    !rejected_at.nil?
  end
end
