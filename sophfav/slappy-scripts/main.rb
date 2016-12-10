# coding: utf-8
require 'twitter'

@favstock = []
@channel = '#bot'

hello do
  puts 'successfly connected'
  @favstock = favs().dup
  # p '@favstock is ...'
  # p @favstock
end

schedule '*/4 * * * *' do
  # puts "check new favs ..."
  newtw = select_new_tweets(favs(), @favstock)
  # puts "nothing new" if newtw.empty?
  newtw.reverse_each do |t|
    puts saying(t)
    say saying(t), channel: @channel
    # stock に 100 以上ツイートがあった場合、古いツイートから消す
    puts "@favstock has #{@favstock.size} items"
    if @favstock.size >= 100
      @favstock.pop
      @favstock.unshift(t)
    else
      @favstock.unshift(t)
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
