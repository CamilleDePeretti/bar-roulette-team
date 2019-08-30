class Bar < ApplicationRecord
  belongs_to :night

  validates :name, presence: true, allow_blank: false
  validates :address, presence: true, allow_blank: false

  def photo?
    placeholder_url = "https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=667&q=80"

    return placeholder_url if photo.nil? || photo.blank?

    photo
  end

  def open?
    return false if open.nil? || close.nil? || open.blank? || close.blank?

    BarHoursService.format(open)
  end

  def close?
    return false if open.nil? || close.nil? || open.blank? || close.blank?

    BarHoursService.format(close)
  end
end
