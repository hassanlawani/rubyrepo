require 'net/http'
require 'json'
require 'uri'

SCHEDULER.every '15s' do
  # Grab current bitcoin price from coinbase
  uri = URI.parse('https://api.bittrex.com/api/v1.1/public/getmarketsummary?market=usd-btc')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)

 send_event('bittrexprice', { value:json_response['result'][0]['Last'].to_f} )
end
