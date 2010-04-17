require 'tweetstream'
require 'grackle'
require 'pp'

u = ENV['RIEGEL_USER']
p = ENV['RIEGEL_PASS']

class Array
  def random
    self[rand(size)]
  end
end

def reply
<<-REPLIES.split('\n').random
Ich schmecke unheimlich gut!
Wer mich isst ist toll.
Ich bin ein Eis für VIPs.
Wenn Sie sich für mich entscheiden, beweisen Sie Geschmack und Prunk.
Ihre Geschmacksnerven werden des Verdrusses verlustig gehen, wenn Sie mich wählen.
Ich schmecke total nach Nogger Riegel. Was gut ist.
Nimm mich! Iss mich! Whoa!
REPLIES
end

client = Grackle::Client.new :auth => { :type => :basic, :username => u, :password => p }
TweetStream::Daemon.new(u,p,'riegel-bot').track('eis') do |status|
  if status.text =~ /eis.*esse|esse.*eis/i
    user = status.user.screen_name
    client.statuses.update! :status => "@#{status.user.screen_name} #{reply} #eisessen"
    puts
    puts status.text
    puts "--"
    puts "@#{status.user.screen_name} #{reply}"
  end
end
