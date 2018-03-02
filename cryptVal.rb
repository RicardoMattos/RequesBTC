require 'net/http'
require 'uri'
require 'json'


# deserualize json obj
def deserialize(json_obj) 
    JSON.parse(json_obj)
end


# return deserialized http body of an url(parameter)
def makeRequest(url)
    header = {'Content-Type': 'text/json'}
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url.request_uri, header)
    response = https.request(request)

    return deserialize(response.body)
end


def btcPrice(values)
    values.each_with_index do |val, _|
        puts "#{val['name']} - #{val['price_btc'].to_s} btc"
    end
end

url = URI.parse('https://api.coinmarketcap.com/v1/ticker/?limit=10')
btcPrice(makeRequest(url))