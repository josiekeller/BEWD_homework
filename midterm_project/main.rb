require_relative 'lib/location'
require_relative 'lib/person'
require_relative 'lib/restaurant'

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


def query_google_maps(location)
	address = location.address.gsub(" ", "+")
	city = location.city.gsub(" ", "+")
	state = location.state.gsub(" ", "+")
	url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address},+#{city},+#{state}&key=AIzaSyA1X5PWoG9AvilyNaJkv0annjzl7Ql7dWU"

	puts "url: #{url}"

	gRes = JSON.load(RestClient.get url)

	puts "gRes: #{gRes}"

	puts "Latitude = #{gRes["results"][0]["geometry"]["location"]["lat"]}"
	puts "Longitude = #{gRes["results"][0]["geometry"]["location"]["lng"]}"
end

# def query_yelp
# end

# def view_restaurants
# end

puts "Welcome to the neighborhood restaurant search, created by Josie Keller."

user = create_user
location = add_location

puts "Location added successfully: \n Name: #{location.name} \n Address: \n #{location.address} \n #{location.city}, #{location.state}"

query_google_maps(location)

#puts "The latitude of that location is #{location.lat} and the longitude is #{location.lng}"

