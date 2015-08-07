# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :proxybotapp do
  desc "Automaticly fetch hosts-files through proxy and write to db"
  task scrape_hosts: :environment do
    puts "Scraping hosts-files..."
    hosts = Scraper.new.scrape.join("<br>").html_safe
    Scraper.create(hosts_files: hosts)
    puts "done"
  end
end
