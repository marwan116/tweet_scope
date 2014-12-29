desc "Grab Tweets"
task :grab_tweets => :environment do
	Keyword.grab_all_tweets
	puts "done."
end
