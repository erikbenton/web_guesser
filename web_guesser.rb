require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
	if params["guess"]
		message, color = check_guess(params["guess"].to_i)		
	else
		message = ""
		color = ""
	end
	cheat = ""
	cheat = params["cheat"] if params["cheat"]

	erb :index, :locals => {:secret_number => SECRET_NUMBER, :message => message, :color => color, :cheat => cheat}
end

def check_guess(guess)
	if guess - SECRET_NUMBER > 5
		message = "Way too high!"
		color = "red"
	elsif guess > SECRET_NUMBER
		message = "Too high!"
		color = "orange"
	elsif guess - SECRET_NUMBER < -5
		message = "Way too low!"
		color = "blue"
	elsif guess < SECRET_NUMBER
		message = "Too low!"
		color = "lightblue"
	elsif guess == SECRET_NUMBER
		message = "You got it right!"
		color = "green"
	end
	return message, color
end