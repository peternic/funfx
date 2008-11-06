require 'rubygems'

require 'funfx/browser/safariwatir'
browser = Watir::Safari.new

browser.goto "http://localhost:9851/index.html"

# Let's grab the Flex app...
flex = browser.flex_app('DemoAppId', 'DemoAppName')

# ...and select a node in the tree
tree = flex.tree({:id => 'objectTree'})
tree.open('Button controls')
tree.select('Button controls>Button1')

# Click a button...
button = flex.button({:automationName => 'Button Control Example'}, {:automationName => 'Default Button'})
button.click

# Print the value of the text area
text_area = flex.text_area({:automationName => "Button Control Example"}, {:id => 'message'})
puts "The value of the message text area:"
puts text_area.text

browser.close