require 'rubygems'
require 'spec'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'funfx'
DEMO_APP = "http://localhost:9851/index.html" unless defined?(DEMO_APP)

def browser
  if $browser.nil?
    require_watir
    $browser = $browser_class.new
    $browser.visible = true if $browser.respond_to?(:visible=)
    at_exit do
      $browser.close
    end
  end
  $browser
end

def require_watir
  if ENV['FIREWATIR'] # Set this in your shell if you want FireFox
    require 'funfx/browser/firewatir'
    $browser_class = FireWatir::Firefox
  else
    case PLATFORM
    when /darwin/
      require 'funfx/browser/safariwatir'
      $browser_class = Watir::Safari
    when /win32|mingw/
      require 'funfx/browser/watir'
      $browser_class = Watir::IE
    when /linux/
      require 'funfx/browser/firewatir'
      $browser_class = FireWatir::Firefox
    else 
      raise "This platform is not supported (#{PLATFORM})"
    end
  end
end
