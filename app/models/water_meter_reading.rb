class WaterMeterReading < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  validates :reading, :user_id, :image, presence: true

  before_validation :set_slug

  paginates_per 10

  def to_param
    slug
  end

  private

  def set_slug
    return unless self.new_record?

    loop do
      self.slug = SecureRandom.uuid
      break unless WaterMeterReading.where(slug: slug).exists?
    end
  end
end
