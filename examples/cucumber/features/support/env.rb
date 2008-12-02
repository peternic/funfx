require 'rubygems'
require 'spec'

$:.unshift(File.dirname(__FILE__) + '/../../../../gem/lib')
#require 'funfx/browser/safariwatir'
#BROWSER = Watir::Safari.new
require 'funfx/browser/firewatir'
BROWSER = FireWatir::Firefox.new
#require 'funfx/browser/watir'
#BROWSER = Watir::IE.new

DEMO_APP = "http://localhost:9851/index.html"

Before do
  BROWSER.goto(DEMO_APP)
  @flex = BROWSER.flex_app('DemoAppId', 'DemoAppName')
end

at_exit do
  BROWSER.close
end