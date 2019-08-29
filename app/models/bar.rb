class Bar < ApplicationRecord
  belongs_to :night
  validates :name, presence: true, allow_blank: false
  validates :address, presence: true, allow_blank: false
end


