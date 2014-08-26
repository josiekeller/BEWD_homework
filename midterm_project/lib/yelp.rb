require 'yelp'

class Client
	@@client = Yelp::Client.new({ consumer_key: "4rR1byY8uspeZvYM5NUmEw",
	                            consumer_secret: "L3hXVKy4Nv33UzJ2jWwCbN4OyM0",
	                            token: "fNXaNI1asjiG3VloQw4Q5MoCX7Ue7jUH",
	                            token_secret: "yOqHaoT9_mSC0fD6rQUcn5S1dfI"
	                          })
	def self.instance
		@@client
	end
end




