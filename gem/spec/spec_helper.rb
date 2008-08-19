begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

case PLATFORM
when /darwin/
  require 'funfx/safari'
  Browser = Watir::Safari
when /win32|mingw/
  require 'funfx/watir'
  Browser = Watir::IE
else
  raise "This platform is not supported (#{PLATFORM})"
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
DEMO_APP = "http://localhost:9851/DemoApp.html"
