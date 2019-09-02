class Bar < ApplicationRecord
  belongs_to :night

  validates :name, presence: true, allow_blank: false
  validates :address, presence: true, allow_blank: false

  def photo?
    placeholder_url = "https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=667&q=80"

    return placeholder_url if photo.nil? || photo.blank?

    photo
  end

  def open_hours(day)
    BarHoursService.format(all_hours(day).first['start'])
  end

  def close_hours(day)
    BarHoursService.format(all_hours(day).first['end'])
  end

  def hours?
    return false if hours.nil? || hours.nil? || hours.blank? || hours.blank?

    true
  end

  private

  def all_hours(day)
    hours_hash = eval(hours)

    hours_hash['timeframes'].each do |hash|
      return hash['open'] if hash['days'].include?(day)
    end
  end
end
