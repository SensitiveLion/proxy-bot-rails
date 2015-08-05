class Schedule < ActiveRecord::Base
  validates :interval, presence: true
  validates :time, presence: true

  INTERVAL = {
    ":hour" => "other day",
    "6.hours" => "six hours",
    "12.hours" => "twelve hours",
    ":day" => "day",
    "2.days" => "other day",
    "3.days" => "three days",
    "4.days" => "four day",
    "5.days" => "five day",
    ":week" => "week",
    ":weekend" => "weekend",
    ":weekday" => "weekday"
  }

  def interval_name
    INTERVAL[interval]
  end

  def time_name
    date_time = time.to_s
    time_zone = date_time.gsub(/2000-01-01\s/,"")
    parsed_time = time_zone.gsub(/:00\sUTC/,"")
    return parsed_time
  end
end

