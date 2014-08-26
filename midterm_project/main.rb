require_relative 'lib/location'
require_relative 'lib/person'
require_relative 'lib/restaurant'
require_relative 'lib/yelp'
require 'pp'
require 'rest-client'
require 'json'

def create_user
	print "What is your name? "
	name = gets.strip

	Person.new(name)
end

def add_location
	puts "Where would you like to search for restaurants?"
	print "Street Address: "
	address = gets.strip
	print "City: "
	city = gets.strip
	print "State: "
	state = gets.strip
	print "What would you like to name this location? "
	name = gets.strip

	Location.new(address, city, state, name)
end

#add a method to format gsub?

def query_google_maps(location)
	address = location.address.gsub(" ", "+")
	city = location.city.gsub(" ", "+")
	state = location.state.gsub(" ", "+")
	url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address},+#{city},+#{state}&key=AIzaSyA1X5PWoG9AvilyNaJkv0annjzl7Ql7dWU"

	gRes = JSON.load(RestClient.get url)

	return { latitude: gRes["results"][0]["geometry"]["location"]["lat"], longitude: gRes["results"][0]["geometry"]["location"]["lng"] }
end

def query_yelp(coordinates)

	params = { term: 'restaurants',
           limit: 5,
         }

	yelp_response = Client.instance.search_by_coordinates(coordinates, params)
	yelp_response.businesses
	# puts yelp_response.businesses[0].name
	# puts yelp_response.businesses[0].rating
end

#def view_restaurants
#end

puts "Welcome to the neighborhood restaurant search, created by Josie Keller."

user = create_user
location = add_location

puts "Location added successfully: \n Name: #{location.name} \n Address: \n #{location.address} \n #{location.city}, #{location.state}"

yelp_response = query_yelp(query_google_maps(location))

yelp_response.each do |restaurant|
	restaurants = {}
	restaurants[:location.name] << [yelp_response[restaurant].name, yelp_response[restaurant].distance, yelp_response[restaurant].display_address]
end

puts restaurants
# puts "The latitude of that location is #{location.lat} and the longitude is #{location.lng}"



