#Building Class
class Building
	attr_accessor :building_name, :building_address, :apartments

	def initialize(building_name, building_address)
		@building_name = building_name
		@building_address = building_address
		@apartments = []
	end

	def view_apartments
		puts "-----------#{building_name}-----------"
		@apartments.each do |view|
			puts "Apartment: #{view.name} sqft: #{view.apt_sqft}  Bedrooms: #{view.apt_bedrooms} Bathrooms: #{view.apt_bathrooms}"
			if view.renter == nil
				puts "This apartment is vacant."
			else
			end
		end
	end
end


