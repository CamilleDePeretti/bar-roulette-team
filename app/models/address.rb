class Address < ApplicationRecord
  belongs_to :night

  validates :address, presence: true, allow_blank: false

  geocoded_by :address, latitude: :lat, longitude: :lng
  after_validation :geocode, if: :will_save_change_to_address?
end


