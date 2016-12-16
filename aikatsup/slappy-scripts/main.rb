# encoding: utf-8
require 'uri'
require 'open-uri'
require 'json'

hello do
  puts 'successfly connected'
end

hear '^aikatsup' do |event|
  key = event.text[/「(.*)」/, 1]
  if key.nil? || key == ''
    say '"aikatsup" のあとに「」でセリフを指定してね', channel: event.channel
  else

    # json データの取得
    key = key.split.join('+')
    url = URI.escape('http://aikatsup.com/api/v1/search?words=' + key)
    data = {}
    open(url) do |i|
      data = JSON.load(i)
    end

    # ヒットした画像 URL のうちからランダムにひとつ投稿
    if data.has_key?('error')
      say 'エラーです。たぶん画像がひとつもみつかりませんでした。', channel: event.channel
    else
      num = data['item'].size
      say data['item'][rand(num)]['image']['url'], channel: event.channel
    end
  end
end


# Slappy Examples
#
# # called when start up
# hello do
#   puts 'successfly connected'
# end
#
#
# # called when match message
# hear 'foo' do
#   puts 'foo'
# end
#
#
# # use regexp in string literal
# hear 'bar (.*)' do |event|
#   puts event.matches[1] #=> Event#matches return MatchData object
# end
#
#
# # event object is slack event JSON (convert to Hashie::Mash)
# hear '^bar (.*)' do |event|
#   puts event.channel #=> channel id
#   say 'slappy!', channel: event.channel #=> to received message channel
#   say 'slappy!', channel: '#general'
#   say 'slappy!', username: 'slappy!', icon_emoji: ':slappy:'
# end
#
#
# # use regexp literal
# hear /^foobar/ do
#   say 'slappppy!'
# end
