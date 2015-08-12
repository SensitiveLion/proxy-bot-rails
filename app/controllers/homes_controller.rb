class HomesController < ApplicationController
  def index
    if Scraper.count == 0
      @scraped = "no hosts-files scraped"
    else
      @scraped = Scraper.last.created_at.localtime.to_formatted_s(:long)
    end
  end
end
