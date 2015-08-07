# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
@scheduler

every 1.hour do
  runner "Schedule.scheduling"
  if interval = "6.hours" || interval = "12.hours"
    @scheduler = interval
    return @scheduler
  else
    @scheduler = "#{interval}, :at => #{time}"
    return @scheduler
  end
end



every 1.day, :at => '3:30 pm' do
  rake "proxybotapp:scrape_hosts"
end
