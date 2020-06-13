class Invitation < ApplicationRecord
  belongs_to :user
  before_validation :generate_token

  validates :email, :token, presence: true

  private

  def generate_token
    return unless self.new_record?

    loop do
      self.token = Devise.friendly_token
      break unless Invitation.where(token: token).exists?
    end
  end
end
