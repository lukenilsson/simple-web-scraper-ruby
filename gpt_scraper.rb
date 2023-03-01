require "nokogiri"
require "open-uri"
require "csv"

# Define the URL to scrape
url = "https://www.chewy.com/brands/homeopet-6907?nav-submit-button=&ref-query=homeopet&ref=searchRedirect"

# Define the user-agent header
user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"

# Open the URL and read the HTML into a variable, including the user-agent header
html = URI.open(url, "User-Agent" => user_agent).read
puts html
puts "===================="
# Use Nokogiri to parse the HTML
doc = Nokogiri::HTML(html)
puts doc
puts "===================="
# Find all the product cards on the page
product_cards = doc.css(".product-card .product-card__content")
puts product_cards
puts "===================="

# Create a new CSV file to store the data
CSV.open("homeopet_products.csv", "w") do |csv|
  # Write the header row
  csv << ["Product Name", "Brand", "Price", "Rating"]

  # Loop through each product card and extract the relevant data
  product_cards.each do |card|
    # Extract the product name
    product_name = card.css(".product-title").text.strip

    # Check if the product brand is Homeopet
    product_brand = card.css(".product-brand").text.strip
    next unless product_brand.downcase == "homeopet"

    # Extract the product price
    product_price = card.css(".product-price .sr-only").text.strip.gsub(/[^\d\.]/, "")

    # Extract the product rating
    product_rating = card.css(".stars-and-numbers__score").text.strip

    # Write the data row to the CSV file
    csv << [product_name, product_brand, product_price, product_rating]
  end
end
