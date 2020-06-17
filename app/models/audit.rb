class Audit < ApplicationRecord
  validates :created_by, :action_type, :record_type, :record_id, presence: true
  default_scope { order(created_at: :desc) }

  paginates_per 10
end
