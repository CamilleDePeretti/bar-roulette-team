class Bar < ApplicationRecord
  belongs_to :night

  validates :name, presence: true, allow_blank: false
  validates :address, presence: true, allow_blank: false

  def photo?
    placeholder_url = "https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=667&q=80"

    return placeholder_url if photos.nil? || photos.blank?

    photos.first
  end

  def open_hours(day)
    BarHoursService.format(all_hours(day).first['start'])
  end

  def close_hours(day)
    BarHoursService.format(all_hours(day).first['end'])
  end

  def hours?
    return false if hours.nil? || hours.empty? || hours.blank?

    true
  end

  def phone?
    contact_hash = eval(contact)
    return false if contact_hash.nil?
    return false if contact_hash['formattedPhone'].nil? || contact_hash['formattedPhone'].empty? || contact_hash['formattedPhone'].blank?

    contact_hash['formattedPhone']
  end

  def price?
    return false if details.nil? || eval(details)['price'].nil?

    eval(details)['price']['tier']
  end

  def currency?
    return false if details.nil? || eval(details)['price'].nil?

    eval(details)['price']['currency']
  end

  def all_hours(day)
    hours_hash = eval(hours)

    hours_hash['timeframes'].each do |hash|
      return hash['open'] if hash['days'].include?(day)
    end

    false
  end
end
