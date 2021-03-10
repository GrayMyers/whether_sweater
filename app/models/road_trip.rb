class RoadTrip < ApplicationRecord
  validates :start, presence:true
  validates :destination, presence: true
end
