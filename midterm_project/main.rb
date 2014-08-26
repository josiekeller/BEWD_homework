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

	params = { term: 'restaurants', limit: 5 }
	yelp_response = Client.instance.search_by_coordinates(coordinates, params)
	
	data = yelp_response.businesses.map do |entry|
		# Each entry is of type BurstStruct which has a built in to_json method.
		# This to_json method extracts the neccessary info into an array
		# of hashes that we can later iterate over
		e = JSON.parse(entry.to_json) 
		{
			name: e["name"],
			distance: e["distance"],
			categories: e["categories"],
			display_address: e["location"]["display_address"]
		}
	end

	return data	
end

puts "Welcome to the neighborhood restaurant search, created by Josie Keller."

user = create_user
location = add_location

puts "Location added successfully: \n Name: #{location.name} \n Address: \n #{location.address} \n #{location.city}, #{location.state}"

restaurants = query_yelp(query_google_maps(location))

#add a method to view_restaurants
#add a method to convert meters to miles

	restaurants.each do |restaurant|
		puts "#{restaurant[:name]} is #{restaurant[:distance]} meters away from #{location.name} at #{restaurant[:display_address]}."
	end

###### Iterate over Yelp responses to store restaurant data in a hash of arrays #############

# restaurants = {}
# restaurants[:location.name] << [yelp_response[restaurant].name, yelp_response[restaurant].distance, yelp_response[restaurant].display_address]
 	

