begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'funfx'
DEMO_APP = "http://localhost:9851/DemoApp.html" unless defined?(DEMO_APP)

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
  if ENV['FIREWATIR']
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
    else
      raise "This platform is not supported (#{PLATFORM})"
    end
  end
end