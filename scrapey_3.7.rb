require "open-uri"
require "nokogiri"

title = Nokogiri::HTML.parse(open("https://apod.nasa.gov/apod/astropix.html")).title

puts title

document = Nokogiri::HTML.parse(open("https://apod.nasa.gov/apod/astropix.html"))
puts "======="
puts document.class
# Nokogiri::HTML::Document
