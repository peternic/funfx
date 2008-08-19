begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'funfx/safari'
DEMO_APP = "file://#{File.expand_path(File.dirname(__FILE__) + '/../../demo-app/lib/DemoApp.html')}"
