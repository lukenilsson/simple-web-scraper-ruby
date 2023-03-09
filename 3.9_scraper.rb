require "nokogiri"
require "open-uri"
require "csv"

url = "https://www.chewy.com/brands/homeopet-6907?nav-submit-button=&ref-query=homeopet&ref=searchRedirect"

html = URI.open(url)
doc = Nokogiri::HTML(html)

doc.css("body > div:nth-child(1) > div:nth-child(9) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(3)").each do |link|
  puts link.content
end

# # Create a new CSV file to store the data
# CSV.open("homeopet_products.csv", "w") do |csv|
#   # Write the header row
#   csv << ["Chewy Price", "List Price", "Autoship Price"]

#   # Loop through each product card and extract the relevant data
#   doc.css.each do |card|
#     # Extract the product name
#     product_name = card.css(".chewy_price").text.strip

#     # Check if the product brand is Homeopet
#     list_price = card.css(".list_price").text.strip
#     next unless product_brand.downcase == "homeopet"

#     # Extract the product price
#     authoship_price = card.css(".list_price .sr-only").text.strip.gsub(/[^\d\.]/, "")

#     # # Extract the product rating
#     # product_rating = card.css(".stars-and-numbers__score").text.strip

#     # Write the data row to the CSV file
#     csv << [chewy_price, list_price, authoship_price]
#   end
# end
