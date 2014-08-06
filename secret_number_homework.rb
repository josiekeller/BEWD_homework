#Introductions
puts "Welcome to Secret Number, written by Josie Keller."
print "What is your name?"
player_name = gets.chomp()
puts "Hi #{player_name}!"
#Instructions
puts "I have randomly selected a number between 1 and 10, inclusive. You will have 3 tries to guess the number. 
If you correctly guess the number within 3 tries, you win. Otherwise, I win! Let's get started."

#The game hard codes a random number between 1 and 10, inclusive and a guess count of 3.
secret_number = rand(1..10)
guess_count = 3

#The following loop gets user input as a guess and provides feedback as to whether the guess is too high, too low,
#or if the user is out of guesses. If they don't guess within 3 tries, the game ends.

while guess_count > 0
	print "Guess a number:"
	user_guess = gets.chomp().to_i
	guess_count -= 1
		if user_guess == secret_number
			puts "Congratulations! #{user_guess} is correct. You win!"
			break
		elsif guess_count == 0
			puts "Sorry! You're out of guesses. The Secret Number was #{secret_number}."
		elsif user_guess > secret_number
			puts "#{user_guess} is too high. You have #{guess_count} chances to guess again!"
		elsif user_guess < secret_number
			puts "#{user_guess} is too low. You have #{guess_count} chances to guess again!"	
		else
			puts "Number was out of range. You have #{guess_count} chances to guess again!"
		end
end
