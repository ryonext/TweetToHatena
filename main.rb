require 'twitter'
require 'pry'
require 'pry-debugger'
require 'oauth'

def get_tweet
  Twitter.configure do |config|
    config.consumer_key = Settings.twitter.consumer_key
    config.consumer_secret = Settings.twitter.consumer_secret
    config.oauth_token = Settings.twitter.oauth_token
    config.oauth_token_secret = Settings.twitter.token_secret
  end
  Twitter.user_timeline("ryonext")
end

def extract_uri(text)
  URI.extract(text, %w[http]).first
end

def create_combination(tweets)
  tweets.map  do |t|
    hash = {}
    hash[:uri] = extract_uri(t.text)
    next if hash[:uri].nil?
    hash[:text] = t.text.delete(hash[:uri])
    hash
  end
end

def create_bookmarks(combi)
  # はてなのoauth情報の処理
  consumer = OAuth::Consumer::new(
    Settings.hatena.consumer_key,
    Settings.hatena.consumer_secret,
    :site => 'https://www.hatena.com/oauth/token',
    :request_token_path => 'https://www.hatena.com/oauth/initiate',
    :access_token_path  => 'https://www.hatena.com/oauth/token',
    :authorize_path     => 'https://www.hatena.ne.jp/oauth/authorize')

  combi.each do |c|
    p c[:uri]
    p c[:text]
  end
end
# 自分のツイートを取る。一日分。
tweets = get_tweet
#tweetとurlの組み合わせを作る(hashのarray)
combi = create_combination(tweets)
combi.delete(nil)
# はてブする
create_bookmarks(combi)

