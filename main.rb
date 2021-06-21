require 'nokogiri'
require 'open-uri'
require 'byebug'

BASE_URL = 'https://santehnika-online.ru'
category_urls = []
urls = ['https://santehnika-online.ru/mebel_dlja_vannoj_komnaty/']

def get_html(url)
  html = open(url) { |result| result.read }
  Nokogiri::HTML(html)
end

urls.each do |category|
  category_urls << category
  page = get_html(category)
  subcategories = page.css('div.collapse-container.collapse-entered > div >' \
                  'div > div > div > div > a').map do |a|
                  BASE_URL + a['href']
  end

  category_urls = category_urls + subcategories

  p category_urls

  category_urls.each do |url|
    page = get_html(category)

    title = page.css('title').text
    h1 = page.css('h1').text
    nodeset  = page.css('head > meta').map do |node|
     (node["name"] == "description") && node["content"]
    end

    description = nodeset.select! { |item| item }
    description = description ? description.join : ''

    puts "Title: #{title}"
    puts "H1: #{h1}"
    puts "Description: #{description}"
    puts "URL: #{url}"
    puts "=" * 40
  end
end
