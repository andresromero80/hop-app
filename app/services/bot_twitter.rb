class BotTwitter

	def initialize
		@client = Twitter::REST::Client.new do |config|
	      config.consumer_key        = ENV['TWITTER_API_KEY']
	      config.consumer_secret     = ENV['TWITTER_SECRET_KEY']
	      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
	      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
		end

		@client_stream = Twitter::Streaming::Client.new do |config|
		  config.consumer_key        = ENV['TWITTER_API_KEY']
	      config.consumer_secret     = ENV['TWITTER_SECRET_KEY']
	      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
	      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
		end
	end 

	def post(string)
		@client.update(string)
	end 

	def topics_search(topic)
		topics = [topic] #["coffee", "tea"]
		@client_stream.filter(track: topics.join(",")) do |object|
		  puts object.text if object.is_a?(Twitter::Tweet)
		end
	end 

	def stream_tweet
		# @client.user do |object|
		# 	puts object.text if object.is_a?(Twitter::Tweet)
		# end 
		text_mentions = []
		begin
		  mentions = @client.mentions_timeline
			mentions.each do |object|
				text_mentions << object.text
			end 

			text_mentions = text_mentions[0,2]
		
		rescue StandardError => e
		  print e

		end
		return text_mentions
	end 
end
