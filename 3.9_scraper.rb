require "nokogiri"
require "open-uri"
require "csv"

url = "https://www.chewy.com/brands/homeopet-6907?nav-submit-button=&ref-query=homeopet&ref=searchRedirect"

html = URI.open(url)
doc = Nokogiri::HTML(html)

CSV.open("output.csv", "wb") do |csv|
  csv << ["Product Name", "Chewy Price", "List Price", "Autoship Price"]
  doc.css(".product-holder").each do |product|
    product_name = product.css(".product-title").text.strip
    chewy_price = product.css(".sr-only").text
    list_price = product.css(".original-price").text
    autoship_price = product.css(".autoship-price").text
    csv << [product_name, chewy_price, list_price, autoship_price]
  end
end
