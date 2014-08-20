class Location
	attr_accessor :address, :city, :state, :name, :lat, :lng, :restaurants

	def initialize (address, city, state, name)
		@address = address
		@city = city
		@state = state
		@name = name
		@lat = lat
		@lng = lng
		@restaurants = []
	end
end