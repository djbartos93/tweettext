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
				puts "Got tweet from user: #{object.created_at} #{object.text}"
				@outfile.write(object.text)
				@outfile.write(" - Downloaded at: ")
				@outfile.write(object.created_at)
				@outfile.flush
				@outfile.seek(0, IO::SEEK_SET)				
				system "./print.sh"
				# this next bit will make sure the output file is empty.
				#lets make tweettext wait until its done printing first.
				sleep(1.0)
				@outfile.truncate(0)
			end
		end
	end
end

setup()
run()
