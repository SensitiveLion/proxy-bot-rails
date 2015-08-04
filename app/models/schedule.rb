class Schedule < ActiveRecord::Base
  validates :interval, presence: true
  validates :time, presence: true

  def options_for_interval
    [
      ["First Option","first_option"],
      ["Second Option","second_option"]
    ]
  end
end

