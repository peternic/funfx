# Serves the HTML/Flex via HTTP
require 'webrick'

s = WEBrick::HTTPServer.new :Port => 9851, :DocumentRoot => File.dirname(__FILE__)
trap("INT"){ s.shutdown }
s.start