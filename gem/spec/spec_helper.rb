begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'funfx/safari'
DEMO_APP = "http://localhost:9851/DemoApp.html"
