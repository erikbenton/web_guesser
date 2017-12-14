require 'sinatra'
require 'sinatra/reloader'

@@number = rand(100)
@@guesses_left = 5

get '/' do
	
	message = ""
	color = ""
	cheat = ""
	@@guesses_left -= 1

	if @@guesses_left == 0
		message = "Game over, a new number has been generated"
		color = "lightgray"
		new_game
	else
		message, color = check_guess(params["guess"].to_i) 	if params["guess"]
		cheat = params["cheat"] 														if params["cheat"]
	end

	erb :index, :locals => {:secret_number => @@number, :message => message, :color => color, :cheat => cheat, :guesses_left => @@guesses_left}
end

def check_guess(guess)
	if guess - @@number > 5
		message = "Way too high!"
		color = "red"
	elsif guess > @@number
		message = "Too high!"
		color = "orange"
	elsif guess - @@number < -5
		message = "Way too low!"
		color = "blue"
	elsif guess < @@number
		message = "Too low!"
		color = "lightblue"
	elsif guess == @@number
		message = "You got it right! A new number has been generated"
		color = "green"
		new_game
	end
	return message, color
end

def new_game

	@@guesses_left = 5
	@@number = rand(100)

end