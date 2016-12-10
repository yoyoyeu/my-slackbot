# coding: utf-8
require File.expand_path('../ignore.rb', __FILE__)
require 'twitter'

# @mine_o さんの最新 favs を 50 件取得
def favs()
  client = Twitter::REST::Client.new(TW_CONFIG)
  return client.favorites(USER_ID, {count:50})
end

def select_new_tweets(newest, stock)
  newtw = []
  newest.each do |i|
    stock_id = stock.collect{|j| j.id}
    newtw << i unless stock_id.include?(i.id)
  end
  newtw
end

def saying(tweet)
  return "#{USER_SCREEN_NAME} liked this: :camera:\n#{tweet.uri.to_s}"
end
