class ScrapersController < ApplicationController
  def index
    @scraper = Scraper.last
  end

  def new
    hosts = Scraper.new.scrape.join("<br>").html_safe
    Scraper.create(hosts_files: hosts)
  end
end
