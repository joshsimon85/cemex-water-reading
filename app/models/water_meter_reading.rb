class WaterMeterReading < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  validates :reading, :user_id, presence: true
  paginates_per 10
end
