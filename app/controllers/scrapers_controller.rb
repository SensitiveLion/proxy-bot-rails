class ScrapersController < ApplicationController
  def index
    @scraper = ["ad_servers", "malware", "exploit", "fraud", "spam", "hpspam",
                "hijacked", "misleading", "illegal_pharma", "phishing", "piracy"]
  end

  def show
    @name = Scraper.where(name: params[:id]).last
  end

  def new
    Scraper.new.scrape
    redirect_to scrapers_path
  end
end
