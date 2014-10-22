require 'httparty'

class JustEatApi
  include HTTParty

  base_uri 'http://api-interview.just-eat.com'
  format   :json

  headers 'Accept-Tenant' => 'uk',
    'Accept-Language' => 'en-GB',
    'Accept-Charset' => 'utf-8',
    'Authorization' => 'Basic VGVjaFRlc3RBUEk6dXNlcjI=',
    'Host' => 'api.just-eat.com'

  def self.list postcode
    response = get('/restaurants', query: { q: postcode })
    restaurants = response.parsed_response["Restaurants"]
    restaurants.map do |r|
      RestaurantModel.new.tap{|m|
        m.name = r["Name"]
        m.logo_url = r["Logo"][0]["StandardResolutionURL"]
        m.cuisines = r["CuisineTypes"].map{|c| c["Name"] }
        m.data = r.inspect
      }
    end

  end

end
