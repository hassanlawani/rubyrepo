require 'twitter'

#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'sK0J04jWB4D9sB1BjQUmLTklk'
  config.consumer_secret = 'PXwkAjt18Xp29yCCOH7V0wMSoVXXoN8UDgsyZ3gcAKISJh3jx4'
  config.access_token = '1171210733511569409-zlxBm6bTzQG0TFWsHdOj3zxvRtPV6f'
  config.access_token_secret = 'JeaQZeVxwT23uKbDnD47HUIh2AWnoIOUPJiYIb3srDlKp'
end

search_term = URI::encode('#bittrexexchange')

SCHEDULER.every '15s', :first_in => 0 do |job|
  begin
    tweets = twitter.search("bittrexexchange")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      puts tweets
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end
