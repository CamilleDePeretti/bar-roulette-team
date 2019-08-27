class Address < ApplicationRecord
  belongs_to :night
end

validates :address, presence: true, allow_blank: false
