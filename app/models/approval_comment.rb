class ApprovalComment < ApplicationRecord
  alias_attribute :request, :approval_request
  alias_attribute :request_id, :approval_request_id

  belongs_to :approval_request
  belongs_to :user

  validates_presence_of :approval_request, :user, :content
end
