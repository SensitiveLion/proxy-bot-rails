class ScrapersController < ApplicationController
  def index
    @scraper = ["ad_servers", "malware", "exploit", "fraud", "spam", "hpspam",
                "hijacked", "misleading", "illegal_pharma", "phishing", "piracy"]
    @malware = ["malwaredomainlist", "malwaredomainlist_ip"]
  end

  def show
    render file: "text_files/#{params["id"]}.txt",  content_type: 'text/plain'
  end

  def new
    Scraper.new.scrape
    redirect_to scrapers_path
  end
end
