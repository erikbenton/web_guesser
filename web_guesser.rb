require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
	if params["guess"]
		message = check_guess(params["guess"].to_i)		
	else
		message = ""
	end

	erb :index, :locals => {:secret_number => SECRET_NUMBER, :message => message}
end

def check_guess(guess)
	if guess - SECRET_NUMBER > 5
		message = "Way too high!"
	elsif guess > SECRET_NUMBER
		message = "Too high!"
	elsif guess - SECRET_NUMBER < -5
		message = "Way too low!"
	elsif guess < SECRET_NUMBER
		message = "Too low!"
	elsif guess == SECRET_NUMBER
		message = "You got it right!"
	end
end