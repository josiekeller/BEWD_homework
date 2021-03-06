# Method to contain Introductions & Instructions
def prompt
	puts "Welcome to Secret Number, written by Josie Keller."
	print "What is your name?"
	player_name = gets.chomp()
	puts "Hi #{player_name}!"
	puts "I have randomly selected a number between 1 and 10, inclusive. You will have 3 tries to guess the number. 
	If you correctly guess the number within 3 tries, you win. Otherwise, I win! Let's get started."
end

def win(ug)
	puts "Congratulations! #{ug} is correct. You win!"
	exit
end

# Method to define what happens if the guess is incorrect
def keep_guessing(ug, sn)
	if ug > sn
		puts "#{ug} is too high. Try again!"
	elsif ug < sn
		puts "#{ug} is too low. Try again!"	
	else
		puts "Number was out of range. Try again!"
	end
end

# Prompt the program to start
prompt

# Hard coded random number
secret_number = rand(1..10)

# Loop to iterate over the 3 guesses
3.downto(1) do |guess|
	print "You have #{guess} guesses. Guess a number between 1 and 10: "
	user_guess = gets.chomp().to_i
	if user_guess == secret_number
		win(user_guess)
	else keep_guessing(user_guess, secret_number)
	end
end

# Output if user runs out of guesses
puts "Sorry! You're out of guesses. The Secret Number was #{secret_number}."