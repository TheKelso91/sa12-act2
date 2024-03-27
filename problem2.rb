require 'net/http'
require 'json'

def format_market_cap(cap)
  if cap >= 1_000_000_000
    "$#{sprintf('%.2f', cap / 1_000_000_000)}B"
  elsif cap >= 1_000_000
    "$#{sprintf('%.2f', cap / 1_000_000)}M"
  else
    "$#{sprintf('%.2f', cap)}"
  end
end

uri = URI('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd')

response = Net::HTTP.get(uri)

data = JSON.parse(response)

sorted_cryptos = data.sort_by { |crypto| crypto['market_cap'] }.reverse

puts "Top 5 Cryptocurrencies by Market Capitalization:"
sorted_cryptos[0..4].each do |crypto|
  puts "#{crypto['name']}: #{format_market_cap(crypto['market_cap'])} (Price: $#{sprintf('%.2f', crypto['current_price'])})"
end
