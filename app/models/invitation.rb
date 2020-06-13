class Invitation < ApplicationRecord
  belongs_to :user

  validates :email, :token, :role, presence: true
end
