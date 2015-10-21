class Scraper < ActiveRecord::Base
  validates :hosts_files, presence: true

  require "mechanize"
  require "nokogiri"
  require "open-uri"


  def scrape
    count = 32

    agent = Mechanize.new
    proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
    link = proxy.links[count]
    if link.uri.to_s == ""
      count -= 1
      link = proxy.links[count]
    end
    proxy = link.click
    proxy_form = proxy.forms.last
    print "."

    until proxy.form.field.name == "q"
      count += 3
      proxy = agent.get("http://www.proxy4free.com/list/webproxy1.html")
      link = proxy.links[count]
      proxy = link.click
      proxy_form = proxy.forms.last
      print "."
    end

    files = {ad_servers: "ad_servers", malware: "emd", exploit: "exp",
            fraud: "fsa", spam: "grm", hpspam: "hfs", hijacked: "hjk",
            misleading: "mmt", illegal_pharma:"pha", phishing: "psh",
            piracy: "wrz"}


    files.each do |key, value|
      @hosts_file = []
      proxy_form.q = "http://hosts-file.net/#{value}.txt"
      proxy = agent.submit(proxy_form)
      print "."
      doc = Nokogiri::HTML(open(proxy.uri.to_s))
      doc_text_full = doc.css("p").to_s
      doc_text_parse = doc_text_full.gsub(/^<p>.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n/, '')
      doc_text_end_parse = doc_text_parse.gsub(/# Hosts:.*\n<\/p>/,'')
      doc_text_ad_parse = doc_text_end_parse.gsub(/#\r\n/,'')
      doc_text = doc_text_ad_parse.gsub(/127.0.0.1\t/,'')
      text = doc_text.split("\r\n")

      text.each do |t|
        @hosts_file << t
      end

      fname = "text_files/#{key.to_s}.txt"
      File.open(fname, "w+") do |f|
        f.puts(@hosts_file)
      end
      print ""
    end

    @hosts_file = []
    proxy = "http://www.malwaredomainlist.com/hostslist/hosts.txt"

    doc = Nokogiri::HTML(open(proxy))
    doc_text_full = doc.css("p").text
    doc_text_parse = doc_text_full.gsub(/.*#/, '')
    doc_text_end_parse = doc_text_parse.gsub(/.*localhost/,'')
    doc_text = doc_text_end_parse.gsub(/127.0.0.1/,'')
    text_empty = doc_text.split("\r\n")
    text = text_empty.reject(&:empty?)

    text.each do |t|
      @hosts_file << t.strip
    end

    fname = "text_files/malwaredomainlist.txt"
    File.open(fname, "w+") do |f|
      f.puts(@hosts_file)
    end

    print "."
    print "done"


    @hosts_file = []
    proxy = "http://www.malwaredomainlist.com/hostslist/ip.txt"
    doc = Nokogiri::HTML(open(proxy))
    text = doc.css("p").text.split("\r\n")

    text.each do |t|
      @hosts_file << t.strip
    end

    fname = "text_files/malwaredomainlist_ip.txt"
    File.open(fname, "w+") do |f|
      f.puts(@hosts_file)
    end

    Scraper.create(name: "updated", hosts_files: "hosts files now in text files")
  end
end
