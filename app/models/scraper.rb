class Scraper < ActiveRecord::Base
  validates :hosts_files, presence: true

  require "mechanize"
  require "nokogiri"
  require "open-uri"


  def scrape
    count = 33

    agent = Mechanize.new
    proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
    link = proxy.links[count]
    proxy = link.click
    proxy_form = proxy.forms.last

    until proxy.form.field.name == "q"
      count += 3
      proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
      link = proxy.links[count]
      proxy = link.click
      proxy_form = proxy.forms.last
    end

    files = {ad_servers: "ad_servers", malware: "emd", exploit: "exp",
            fraud: "fsa", spam: "grm", hpspam: "hfs", hijacked: "hjk",
            misleading: "mmt", illegal_pharma:"pha", phishing: "psh",
            piracy: "wrz"}



    files.each do |key, value|
      @compile = []

      proxy_form.q = "http://hosts-file.net/#{value}.txt"
      proxy = agent.submit(proxy_form)
      doc = Nokogiri::HTML(open(proxy.uri.to_s))
      doc_text_full = doc.css("p").to_s
      doc_text_parse = doc_text_full.gsub(/^<p>.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n/, '')
      doc_text_end_parse = doc_text_parse.gsub(/# Hosts:.*\n<\/p>/,'')
      doc_text_ad_parse = doc_text_end_parse.gsub(/#\r\n/,'')
      doc_text = doc_text_ad_parse.gsub(/127.0.0.1\t/,'')
      text = doc_text.split("\r\n")

      text.each do |t|
        @compile << t
      end

      hosts = @compile.join("\n").html_safe
      name = key.to_s
      Scraper.create(name: name, hosts_files: hosts)
    end
  end
end
