class ScrapersController < ApplicationController
  def index
    binding.pry
  end

  def create
    hosts = Scraper.scrape
  end
end
