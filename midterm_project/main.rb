require_relative 'lib/location'
require_relative 'lib/person'
require_relative 'lib/yelp'
require 'pp'
require 'rest-client'
require 'json'

# Global Variables
address_book = {}

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

def store_locations(address_book, location, restaurants)
	address_book.store(location.name, restaurants)
	return address_book
end

def add_more_locations(address_book)
	location = add_location
	puts "Location added successfully: \n Name: #{location.name} \n Address: \n #{location.address} \n #{location.city}, #{location.state}"

	restaurants = query_yelp(query_google_maps(location))
	view_restaurants(restaurants, location)

	locations = store_locations(address_book, location, restaurants)

	puts "Would you like to add another location search? (y/n)"
	get_user_input(address_book)
end

def view_restaurants(restaurants, location)
	restaurants.each do |restaurant|
		puts "#{restaurant[:name]} is #{restaurant[:distance].round(2)} meters away from #{location.name} at #{restaurant[:display_address].join(', ')}."
	end
end

def view_locations(address_book)
	address_book.each do |key, array|
  		puts "Location: #{key}"
  		array.each do |restaurant|
  			puts "\tRestaurant: #{restaurant[:name]}\n\t\tCategories: #{restaurant[:categories].join(', ')}\n\t\tAddress: #{restaurant[:display_address].join(', ')}"
		end
	end	
end

def get_user_input(address_book)
	user_input = gets.chomp
		if user_input == "y"
			add_more_locations(address_book)
		end
end

puts "Welcome to the neighborhood restaurant search, created by Josie Keller."

user = create_user
add_more_locations(address_book)

view_locations(address_book)


