class ApplicationController < ActionController::Base
  helper_method :options_for_interval

  def options_for_interval
    [
      ["Every other day", ":hour"],
      ["Every six hours", "6.hours"],
      ["Every twelve hours", "12.hours"],
      ["Every day", ":day"],
      ["Every other day", "2.days"],
      ["Every three days", "3.days"],
      ["Every four day", "4.days"],
      ["Every five day", "5.days"],
      ["Every week", ":week"],
      ["Every weekend", ":weekend"],
      ["Every weekday", ":weekday"]
    ]
  end

  protect_from_forgery with: :exception
end
