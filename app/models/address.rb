class Address < ApplicationRecord
  belongs_to :night
  validates :address, presence: true, allow_blank: false
end

