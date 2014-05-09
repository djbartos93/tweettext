require 'rubygems'
require 'bundler/setup'

require 'twitter'
require 'yaml'

def setup
	# Load some config stuff
	@configFile = YAML::load(File.open('config.yml'))

	# Setup twitter client
	@client = Twitter::Streaming::Client.new do |config|
		config.consumer_key = @configFile['API_KEY']
		config.consumer_secret = @configFile['API_SECRET']
		config.access_token = @configFile['ACCESS_TOKEN']
		config.access_token_secret = @configFile['ACCESS_TOKEN_SECRET']
	end

	# Try and open the file to ouput
	@outfile = File.open(@configFile['OUTPUT_FILE'], mode="w+")
end

def run
	@client.user do |object|
		case object
		when Twitter::Tweet
			if object.user.screen_name == @configFile['USER_ID']
				puts "Got tweet from user: #{object.text}"
				@outfile.write(object.text)
				@outfile.flush
				@outfile.seek(0, :SET)
			end
		end
	end
end

setup()
run()