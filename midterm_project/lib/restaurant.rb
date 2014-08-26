class Restaurant
	attr_accessor :name, :distance, :category, :display_address

	def initialize (name, distance, category, display_address)
		@name = name
		@distance = distance
		@category = category
		@display_address = display_address
	end
end