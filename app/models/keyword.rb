class Keyword < ActiveRecord::Base
	has_many :tweets, dependent: :destroy
	def grab_tweets
		client= Twitter::REST::Client.new do |config|
		 config.consumer_key="7Gt9c6xErVzHJkzQ7enboUGuK"
		 config.consumer_secret="RiBFy5tuDAble6WCSLVFVnCXy67wlDOfP76iP7X6G0p2wyDjB2"
		 config.oauth_token="289226730-dm6XcbAgU74sFznfsZlLDfVwXJdAmjXDPiT3wDoR"
		 config.oauth_token_secret="DPP5S8eWD3rkY7n3qh39uEkjCbT1D2cNwBwbNfbaiKq1b"
		end
		client.search(self.word, :count=>100, :result_type => 'recent').take(100).collect do |tweet|
			new_tweet= Tweet.new

			new_tweet.tweet_id= tweet.id.to_s
			new_tweet.tweet_created_at=tweet.created_at
			new_tweet.text=tweet.text

			new_tweet.user_uid= tweet.user.id
			new_tweet.user_name=tweet.user.user_name
			new_tweet.user_screen_name=tweet.user.screen_name
			new_tweet.user_image_url=tweet.user.profile_image_url.to_s

			new_tweet.keyword=self

			new_tweet.save
		end
	end

	def self.grab_all_tweets
		Keyword.all.each do |keyword|
			keyword.grab_tweets
		end
	end
end
