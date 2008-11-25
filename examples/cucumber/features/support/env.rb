require 'rubygems'
require 'spec'
require 'funfx/browser/safariwatir'
BROWSER = Watir::Safari.new
DEMO_APP = "http://localhost:9851/index.html"

Before do
  BROWSER.goto(DEMO_APP)
  @flex = BROWSER.flex_app('DemoAppId', 'DemoAppName')
end

at_exit do
  BROWSER.close
end