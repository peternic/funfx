begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

unless defined?(Watir::Browser)
  $:.unshift(File.dirname(__FILE__) + '/../lib')
  case PLATFORM
  when /darwin/
    require 'funfx/safari'
    Watir::Browser = Watir::Safari
  when /win32|mingw/
    puts caller.inspect
    require 'funfx/watir'
    Watir::Browser = Watir::IE
  else
    raise "This platform is not supported (#{PLATFORM})"
  end

  DEMO_APP = "http://localhost:9851/DemoApp.html"
end