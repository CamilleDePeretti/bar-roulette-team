class Night < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :bars, dependent: :destroy
end
