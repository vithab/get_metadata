require 'nokogiri'
require 'open-uri'

urls = ['https://santehnika-online.ru/product/mebel_dlya_vannoy_stworki_montre_60_belaya/',
        'https://spa-swim.ru/product/bellagio-luxury-cesano',
        'https://www.santehnica.ru/product/195214.html',
        'https://shower5.ru/collection/kabiny80x80']

def get_html(url)
  html = open(url) { |result| result.read }
  Nokogiri::HTML(html)
end

urls.each do |url|
  page = get_html(url)
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
