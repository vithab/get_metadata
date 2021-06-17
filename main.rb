require 'nokogiri'
require 'open-uri'

url = 'https://santehnika-online.ru/product/mebel_dlya_vannoy_stworki_montre_60_belaya/'
# url = 'https://spa-swim.ru/product/bellagio-luxury-cesano'
# url = 'https://www.santehnica.ru/product/195214.html'
# url = 'https://shower5.ru/collection/kabiny80x80'

html = open(url) { |result| result.read }
page = Nokogiri::HTML(html)

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
