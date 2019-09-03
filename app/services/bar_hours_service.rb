class BarHoursService
  def self.format(time)
    return time[1..2] + ":" + time[3..4] if time.length > 4

    time[0..1] + ":" + time[2..3]
  end

  def self.today
    day = Date.today.wday
    day = 7 if day == 0

    day
  end
end
