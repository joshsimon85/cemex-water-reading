class User < ApplicationRecord
  has_many :water_meter_readings
  has_many :invitations
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  before_create :set_slug

  validates :full_name, presence: true

  paginates_per 20

  def admin?
    admin
  end

  def to_param
    slug
  end

  private

  def set_slug
    return unless self.new_record?

    loop do
      self.slug = SecureRandom.uuid
      break unless User.where(slug: slug).exists?
    end
  end
end
