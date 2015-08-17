require 'rufus-scheduler'
require 'rake'

scheduler = Rufus::Scheduler.new

scheduler.cron '30 15 * * 1,2,3,4,5'  do
  puts 'Hello... Rufus'
  system("rake proxybotapp:scrape_hosts")
end

scheduler.join
