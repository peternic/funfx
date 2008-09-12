# Serves the HTML/Flex via HTTP
require 'webrick'

s = WEBrick::HTTPServer.new :Port => 9851, :DocumentRoot => File.dirname(__FILE__)
trap("INT"){ s.shutdown }
puts
puts "*** The Flex Demo app is available on http://localhost:9851/DemoApp.html ***"
puts
s.start
